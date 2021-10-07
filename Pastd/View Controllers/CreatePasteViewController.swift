//
//  CreatePasteViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/4/21.
//

import UIKit

var api_reply: String?
struct Reply: Codable {
    let key: String
}

public var key_received = ""
class CreatePasteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    
    var url = "https://9dghkv.deta.dev/create_paste/new?heading="
    var url2 = "&body="
    
    @IBOutlet weak var heading_field: UITextField!
    @IBOutlet weak var body_field: UITextView!
    @IBOutlet weak var access_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        access_btn.layer.cornerRadius = 20
        Utilities.styleTextField(heading_field)
        body_field.layer.borderWidth = 3
        body_field.layer.cornerRadius = 20
        body_field.layer.borderColor = UIColor.init(red: 80/255, green: 0/255, blue: 19/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreatePasteViewController.keyboarddismiss))
                           view.addGestureRecognizer(tap)
                           heading_field.delegate = self
                           body_field.delegate = self
               
           }
           
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       heading_field.resignFirstResponder()
       body_field.resignFirstResponder()
              return true
          }
          @objc func keyboarddismiss() {
                 view.endEditing(true)
          }

    private func fetchData(from url: String){
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something Went Wrong!")
                return
            }
            var result: Reply?
            do{
                result = try JSONDecoder().decode(Reply.self, from: data)
            }
            catch{
                print("Failed to convert \(error)")
            }
            guard let json = result else{
                return
            }
            print(json.key)
            
            DispatchQueue.main.async {
                key_received = json.key
                print(key_received)
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                self.performSegue(withIdentifier: "show_key", sender: nil)

            }
        }).resume()
    }
    
    @IBAction func submit_paste(_ sender: Any) {
        
        if (heading_field.text?.isEmpty == false || body_field.text?.isEmpty == false){
            
            let head = heading_field.text!.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed)
            let bod = body_field.text!.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed)
            
            let endpoint = "\(url)" + "\(head!)" + "\(url2)" + "\(bod!)"
            print(endpoint)
            
            fetchData(from: endpoint)
        }else{
            
            create_alert(NewTitle: "Empty Field(s)", msg: "One Or More Fields Are Empty!")
        }
        
    
    }
    
    
    func create_alert(NewTitle: String, msg: String){
            let alert = UIAlertController(title: NewTitle, message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        
        }
    
}
