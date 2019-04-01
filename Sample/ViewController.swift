//
//  ViewController.swift
//  ColourWheel
//
//  Created by jdstmporter on 01/07/2019.
//  Copyright (c) 2019 jdstmporter. All rights reserved.
//

import UIKit
import ColourWheel


    class ViewController: UIViewController {
        
        
        @IBOutlet weak var colourWheel: ColourWheelControl!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            //colorWheel=ColourWheelControl(frame: view.bounds)
            //view.addSubview(colorWheel)
        }
        
        @IBAction func colourChanged(_ sender: Any) {
            print("New colour is \(colourWheel.colour)")
        }
        
        
    }



