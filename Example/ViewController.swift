//
//  ViewController.swift
//  example
//
//  Created by Julian Porter on 31/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
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

