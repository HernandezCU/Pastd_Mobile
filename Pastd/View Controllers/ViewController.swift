//
//  ViewController.swift
//  Pastd
//
//  Created by Carlos Hernandez on 10/4/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var find_paste_btn: UIButton!
    @IBOutlet weak var create_a_paste_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        find_paste_btn.layer.cornerRadius = 20
        create_a_paste_btn.layer.cornerRadius = 20
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 )
            let cell = CAEmitterCell()
            cell.birthRate = 5
            cell.lifetime = 20
            cell.velocity = 100
            cell.scale = 0.25
            cell.emissionRange = 360 * (CGFloat.pi / 180)
            cell.contents = UIImage(named: "clipboard")!.cgImage
        
            let cell2 = CAEmitterCell()
            cell2.birthRate = 2
            cell2.lifetime = 20
            cell2.velocity = 100
            cell2.scale = 0.03
            cell2.emissionRange = 360 * (CGFloat.pi / 180)
            cell2.contents = UIImage(named: "globe")!.cgImage
        
            emitterLayer.emitterCells = [cell, cell2]
                
            view.layer.insertSublayer(emitterLayer, at: 0)

            
    }
    
    

}

