//
//  control.swift
//  Swifted
//
//  Created by Julian Porter on 07/01/2019.
//  Copyright © 2019 Justin Meiners. All rights reserved.
//

import UIKit

@IBDesignable
public class ColourWheelControl : UIControl {
    
    private var colorWheel : ColorWheel!
    private var brightnessSlider : BrightnessSlider!
    private var wellView : UIView!
    
    private var side : CGFloat { return bounds.size.min }
    private var wheelSize : CGSize { return CGSize(side: 0.75*side) }
    private var wheelFrame : CGRect {
        let origin = CGPoint(x: (bounds.width-wheelSize.width)*0.5,y: side*0.05)
        return CGRect(origin: origin,size: wheelSize)
    }
    private var sliderFrame : CGRect {
        let x=wheelFrame.minX+side*0.2
        
        return CGRect(x: x,y: 0.85*side,width: wheelFrame.maxX-x,height: 0.1*side)
    }
    private var wellFrame: CGRect {
        let x=wheelFrame.minX
        return CGRect(x: x,y: 0.85*side,width: 0.1*side,height:0.1*side)
    }
    
    
    private func initialise() {
        backgroundColor = .white
        colorWheel=ColorWheel(frame: wheelFrame)
        colorWheel.delegate = { self.colorWheelDidChangeColor($0) }
        colorWheel.continuous = true
        addSubview(colorWheel)
        
        brightnessSlider=BrightnessSlider(frame: sliderFrame)
        brightnessSlider.borderWidth=2
        brightnessSlider.borderColor = .black
        brightnessSlider.continuous=true
        brightnessSlider.delegate  = { self.changeBrightness($0) }
        addSubview(brightnessSlider)
        
        wellView=UIView(frame: wellFrame)
        wellView.layer.borderColor = UIColor.black.cgColor
        wellView.layer.borderWidth = 2
        addSubview(wellView)
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    public override func layoutSubviews() {
        colorWheel.frame=wheelFrame
        brightnessSlider.frame=sliderFrame
        wellView.frame=wellFrame
        setNeedsDisplay()
    }
    
    func changeBrightness(_ slider: BrightnessSlider) {
        wellView.backgroundColor=brightnessSlider.currentColor
        sendActions(for: .valueChanged)
    }
    
    func colorWheelDidChangeColor(_ colorWheel : ColorWheel) {
        
        brightnessSlider.setBaseColor(colorWheel.currentColor)
        wellView.backgroundColor=brightnessSlider.currentColor
        sendActions(for: .valueChanged)
    }
    
    @IBInspectable public var colour : UIColor {
        get { return brightnessSlider.currentColor }
        set {
            brightnessSlider.setBaseColor(newValue)
            colorWheel.currentColor=newValue
            setNeedsDisplay()
        }
    }
    
    
}
