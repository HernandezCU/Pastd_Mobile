//
//  PasteViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/6/21.
//

import UIKit

var answer: String?

struct delete_paste: Codable {
    let code: Int
    let message: String
}

class PasteViewController: UIViewController {

    @IBOutlet weak var delete_paste_btn: UIButton!
    @IBOutlet weak var heading_label: UITextView!
    @IBOutlet weak var body_label: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heading_label.backgroundColor = .white
        body_label.backgroundColor = .white
        print("view loaded!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (error_receieved == "YES"){
            
            create_alert(NewTitle: "Invalid Key", msg: "The Key You Entered Does Not Exist!")
            
        }else{
            
            delete_paste_btn.isHidden = false
            delete_paste_btn.layer.cornerRadius = 20
            heading_label.layer.borderWidth = 0
            heading_label.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.0)
            body_label.layer.borderWidth = 0
            body_label.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.0)
            
            heading_label.text = heading_received
            body_label.text = body_received

        }
    }
    
    func create_alert(NewTitle: String, msg: String){
        
            let alert = UIAlertController(title: NewTitle, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
    
        }

    @IBAction func del_paste(_ sender: Any) {
        let url = "https://9dghkv.deta.dev/delete/del?key="
        let endpoint = url + key_received
        
        fetchData(from: endpoint)
    }
    
    private func fetchData(from url: String){
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, answer, error in
            guard let data = data, error == nil else {
                print("Something Went Wrong!")
                return
            }
            var result: delete_paste?
            do{
                result = try JSONDecoder().decode(delete_paste.self, from: data)
            }
            catch{
                print("Failed to convert \(error)")
            }
            guard let json = result else{
                return
            }
            print(json.code)
            print(json.message)
            
            
            DispatchQueue.main.async {
                
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                self.create_alert(NewTitle: "Success!", msg: String(json.code) + "\n" + json.message)

            }
        }).resume()
    }
    
}
