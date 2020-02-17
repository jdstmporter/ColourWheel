//
//  ColourPickerVC.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 23/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation
import UIKit
//import ColourWheel
import SwiftUI

class ColourPickerVC: UIViewController, FromStoryboard {
    
    @IBOutlet weak var picker: ColourWheelControl!
    
    static let controller = ColourPickerVC.fromStoryboard()
    
    var color:UIColor?
    
    @IBAction func cload(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func colourChanged(_ sender: Any) {

    }
    
    

    static func pickColour(colour:UIColor, from:UIViewController){

        let picker = ColourPickerVC.controller
        picker.color = colour
        from.present(picker, animated: true)
    }

}
