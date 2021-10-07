//
//  KeyViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/5/21.
//

import UIKit

class KeyViewController: UIViewController {

    @IBOutlet weak var key_display_field: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Utilities.styleTextField(key_display_field)
        key_display_field.text = key_received
        UIPasteboard.general.string = key_display_field.text!
        
    }
    


}
