//
//  control.swift
//  Swifted
//
//  Created by Julian Porter on 07/01/2019.
//  Copyright © 2019 Justin Meiners. All rights reserved.
//

import UIKit



/**
 
 ColourWheelControl defines a simple UIKit control that provides interactive colour-picker capability.
 
    The class is @IBDesignable, so it works naturally with XCode's Interface Designer.  It inherits from `UIControl` and so exhibits all the usual configuration properties (e.g. background colour, border, `UIEvent`, etc) and functions, e.g. it manages its own layout.

 Inspectable properties:
    - brightnessEnabled
    - nBits
    - colour
 
 Events:
 
    The event  `UIEvent.valueChanged` is fired whenever the selected colour changes
   
 
   
 
 */
@IBDesignable
public class ColourWheelControl : UIControl {
    
    /**
     Whether or nor the optional brigtness-chooser strip is visible / active in the control.
     
    Warning:
     This parameter should be set once and for all when the control is instantiated; changing it dynamically may have unforseen side-effects.
     
    Default:
     **true** (brightness control enabled)
     */
    @IBInspectable public var brightnessEnabled : Bool = true
    
    private var colorWheel : ColorWheel!
    private var brightnessSlider : BrightnessSlider?
    private var wellView : UIView!
    
    private var side : CGFloat { return bounds.size.min }
    private var wheelSize : CGSize { return CGSize(side: 0.75*side) }
    private var wheelFrame : CGRect {
        let origin = CGPoint(x: (bounds.width-wheelSize.width)*0.5,y: side*0.05)
        return CGRect(origin: origin,size: wheelSize)
    }
    private var sliderFrame : CGRect {
        guard brightnessEnabled else { return CGRect() }
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
        
        if brightnessEnabled {
            brightnessSlider=BrightnessSlider(frame: sliderFrame)
            brightnessSlider?.borderWidth=2
            brightnessSlider?.borderColor = .black
            brightnessSlider?.continuous=true
            brightnessSlider?.delegate  = { self.changeBrightness($0) }
            addSubview(brightnessSlider!)
        }
        
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
        brightnessSlider?.frame=sliderFrame
        wellView.frame=wellFrame
        setNeedsDisplay()
    }
    
    func changeBrightness(_ slider: BrightnessSlider) {
        guard brightnessEnabled else { return }
        wellView.backgroundColor=brightnessSlider?.currentColor
        sendActions(for: .valueChanged)
    }
    
    func colorWheelDidChangeColor(_ colorWheel : ColorWheel) {
        if brightnessEnabled {
            brightnessSlider?.setBaseColor(colorWheel.currentColor)
            wellView.backgroundColor=brightnessSlider?.currentColor
        }
        else {
           wellView.backgroundColor=colorWheel.currentColor
        }
        sendActions(for: .valueChanged)
    }
    
    /**
        The currently selected colour.  Writing to it resets the control to point at the specified colour.
     
     Events:
     
        The event  `UIEvent.valueChanged` is fired whenever the selected colour changes.
     
        Events are managed in the usual manner for UIControl instances, nd so the control can be wired up in Interface Builder like any other control.
     */
    @IBInspectable public var colour : UIColor {
        get { return brightnessSlider?.currentColor ?? colorWheel.currentColor }
        set {
            brightnessSlider?.setBaseColor(newValue)
            colorWheel.currentColor=newValue
            setNeedsDisplay()
        }
    }
    
    /**
     The number of bits used to represent colour components (so setting it to 3  would give 3 bits per colour component,
     i.e. 8 levels for each of RGB or HSV).  This can be useful if you want to restrict the palette available to users.
     
     Default:
       8 (standard 24 bit colour HSV).
     
     */
    @IBInspectable public var nBits : UInt {
        get { return colorWheel.nBits }
        set {
            colorWheel.nBits=newValue
            brightnessSlider?.nBits=newValue
        }
    }
    
    
}
