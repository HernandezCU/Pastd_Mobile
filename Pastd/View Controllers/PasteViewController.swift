//
//  PasteViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/6/21.
//

import UIKit

class PasteViewController: UIViewController {

    @IBOutlet weak var delete_paste_btn: UIButton!
    @IBOutlet weak var heading_label: UITextView!
    @IBOutlet weak var body_label: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (error_receieved == "YES"){
            
            create_alert(NewTitle: "Invalid Key", msg: "The Key You Entered Does Not Exist!")
            dismiss(animated: true, completion: nil)
            
        }else{
        
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
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    
        }

 
    
}
