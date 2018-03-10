//
//  ViewController.swift
//  EasyCam
//
//  Created by shalomfriss on 03/10/2018.
//  Copyright (c) 2018 shalomfriss. All rights reserved.
//

import UIKit
import EasyCam

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        EasyCam.autoCorrect = false
        EasyCam.shared.showActionSheet(vc: self)
        EasyCam.shared.imagePickedBlock = { (image) in
            print("Done")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

