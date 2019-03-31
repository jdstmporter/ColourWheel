//
//  knobView.swift
//  Swifted
//
//  Created by Julian Porter on 21/12/2018.
//  Copyright © 2018 Justin Meiners. All rights reserved.
//

import UIKit



public class Cursor {
    
    private var size : CGSize
    private var borderWidth : CGFloat
    
    init(size s :CGSize, borderWidth w: CGFloat) {
        size=s
        borderWidth=w
    }
    
    public func draw(context ctx: CGContext?, at p : CGPoint, colour: CGColor) {
        let f=CGRect(origin: p-size.mid,size: size)
        ctx?.addEllipse(in: f.insetBy(dx: borderWidth, dy: borderWidth))
        ctx?.setLineWidth(0.5*borderWidth)
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.strokePath()
        ctx?.addEllipse(in: f.insetBy(dx: borderWidth, dy: borderWidth))
        ctx?.setFillColor(UIColor.black.cgColor)
        ctx?.fillPath()
        ctx?.addEllipse(in: f.insetBy(dx: 1.5*borderWidth, dy: 1.5*borderWidth))
        ctx?.setFillColor(colour)
        ctx?.fillPath()
    }
}
