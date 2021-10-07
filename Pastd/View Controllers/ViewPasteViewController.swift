//
//  ViewPasteViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/4/21.
//

import UIKit

var response: String?

struct Note: Codable {
    let body: String
    let heading: String
    let key: String
    let error: String
}

public var body_received = ""
public var heading_received = ""
public var key_from_reply = ""
public var error_receieved = ""

class ViewPasteViewController: UIViewController, UITextFieldDelegate {

    var url = "https://9dghkv.deta.dev/fetch_paste/paste?key="
        
    @IBOutlet weak var code_field: UITextField!
    @IBOutlet weak var access_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        access_btn.layer.cornerRadius = 20
        Utilities.styleTextField(code_field)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewPasteViewController.keyboarddismiss))
                           view.addGestureRecognizer(tap)
                           code_field.delegate = self
               
           }
           
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        code_field.resignFirstResponder()
        return true
    }
    @objc func keyboarddismiss() {
        view.endEditing(true)
    }
    
    
    private func fetchData(from url: String){
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something Went Wrong!")
                return
            }
            var result: Note?
            do{
                result = try JSONDecoder().decode(Note.self, from: data)
            }
            catch{
                print("Failed to convert \(error)")
            }
            guard let json = result else{
                return
            }
            print(json.body)
            print(json.heading)
            print(json.key)
            print(json.error)
            
            
            DispatchQueue.main.async {
                body_received = json.body
                heading_received = json.heading
                key_from_reply = json.key
                error_receieved = json.error
                
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                self.performSegue(withIdentifier: "view_paste", sender: nil)

            }
        }).resume()
    }
    

    @IBAction func access_paste(_ sender: Any) {
        
        if code_field.text!.isEmpty == false{
            
            let k = code_field.text!.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed)
            
            let endpoint = "\(url)" + "\(k!)"
            fetchData(from: endpoint)
        }else{
            
            create_alert(NewTitle: "Empty Field", msg: "Code Field Cannot be Empty!")
        }
        
    }
    
    
    func create_alert(NewTitle: String, msg: String){
            let alert = UIAlertController(title: NewTitle, message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        
        }

}
