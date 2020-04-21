//
//  ViewController.swift
//  ShapeThree
//
//  Created by Harut on 4/21/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let circle = Circle()
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
     }
     @IBAction func circle(_ sender: UIButton) {
         circle.drawCircle()
     }
     
}

