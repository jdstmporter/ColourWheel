//
//  ViewController.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 17/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import UIKit
import SwiftUI
//import PureLayout
import Combine

class ViewController: UIViewController {
  
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
             

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @IBAction func pickColour(_ sender: Any) {
        ColourPickerVC.pickColour(colour: .red, from: self)
    }
    
    
}

