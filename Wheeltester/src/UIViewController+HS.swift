//
//  UIViewController+HS.swift
//  Rhythm101
//
//  Created by Михаил Барашков on 05.06.2018.
//  Copyright © 2018 Tinkerswitch. All rights reserved.
//

import Foundation
import UIKit

protocol FromStoryboard: class {
    static var storyboardFilename:String {get}
    static var storyboardId:String {get}
    static func fromStoryboard() -> Self
}

extension FromStoryboard where Self: UIViewController {
    
    
    /// Load VC from storyboard
    /// Storyboard ID is by default assumed to be the class name
    /// - Returns: the VC
    static func fromStoryboard() -> Self {
        let board = UIStoryboard.init(name: self.storyboardFilename, bundle: nil)
        
        guard let vc = board.instantiateViewController(withIdentifier: storyboardId) as? Self else {
            fatalError("Unable to instantiate storyboard with identifier: \(storyboardId)")
        }
        return vc
    }
    
    static var storyboardFilename:String {return String(describing: self)}
    static var storyboardId:String {return String(describing: self)}

}
