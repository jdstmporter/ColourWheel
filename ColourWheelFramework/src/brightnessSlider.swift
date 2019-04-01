//
//  brightnessSlider.swift
//  Swifted
//
//  Created by Julian Porter on 21/12/2018.
//  Copyright © 2018 Justin Meiners. All rights reserved.
//

import UIKit


public typealias BrightnessChangeCallback = (BrightnessSlider) -> Void
public class BrightnessSlider : UIControl {
    
    
    public var delegate : BrightnessChangeCallback? = nil
    public var continuous : Bool = false
    public var borderColor : UIColor  {
        get { if let cg=layer.borderColor { return UIColor(cgColor: cg) } else { return UIColor.black } }
        set { layer.borderColor=newValue.cgColor }
    }
    public var borderWidth : CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth=newValue }
    }
    public var baseColor : HSVPixel = HSVPixel(0, 0, 1)
    
    public var brightness : CGFloat=1.0
    
    private var image : CGImage?
    private var imageData : [UInt8] = []
    private var width : Int = 0
    private var height : Int = 0
    private var cursor : Cursor!
    private var touchPoint : CGPoint!
    
    private var colours : ColourSource!
    
    public var nBits : UInt {
        get { return colours?.nBits ?? 0 }
        set { colours = ColourSource(bits: newValue) }
    }
    
    
    internal func initialise() {
        backgroundColor = .clear
        width=Int(bounds.width)
        height=Int(bounds.height)
        cursor=Cursor(size: CGSize(boxed: bounds.size*0.5), borderWidth: 2)
        nBits=8
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        initialise()
    }
    
    
    public func setBaseColor(_ c : UIColor) {
        let hsv=HSVPixel(c)
        baseColor=hsv
        updateImage()
    }
    
    private func brightnessAt(_ x : CGFloat) -> CGFloat {
        return 1-(CGFloat(x)/bounds.width).bound(min: 0, max: 1)
    }
    
    private func colorAtPoint(_ x: Int) -> [UInt8] {
        let frac=brightnessAt(CGFloat(x))
        return colours.colour(baseColor.h, baseColor.s, frac).bytes 
    }
    
    public var currentColor : UIColor {
        return HSVPixel(baseColor.h, baseColor.s, brightness).ui
    }
    
    private func updateImage() {
        if bounds.width==0 || bounds.height==0 { return }
        image=nil
        
        let dataLength = 3*width*height
        imageData=Array<UInt8>(repeating: 0, count: dataLength)
        
        var offset : Int = 0
        (0..<height).forEach { _ in
            (0..<width).forEach { x in
                imageData.replaceSubrange(offset..<(offset+3), with: colorAtPoint(x))
                offset+=3
            }
        }
        if let provider=CGDataProvider(dataInfo: nil,data: &imageData,size: dataLength,releaseData: { (_,_,_) in }) {
            image=CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 24, bytesPerRow: width*3,
                                space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: .byteOrderMask, provider: provider,
                                decode: nil, shouldInterpolate: true, intent: .defaultIntent)
        }
        setNeedsDisplay()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t=touches.first {
            touchPoint=t.location(in: self)
            if self.bounds.contains(touchPoint) {
                brightness=brightnessAt(touchPoint.x)
                delegate?(self)
                setNeedsDisplay()
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t=touches.first {
            touchPoint=t.location(in: self)
            if self.bounds.contains(touchPoint) {
                brightness=brightnessAt(touchPoint.x)
                if continuous {
                    delegate?(self)
                    setNeedsDisplay()
                }
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        width=Int(bounds.width)
        height=Int(bounds.height)
        updateImage()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ctx=UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        
        if let r=image {
            let rect=bounds.insetBy(dx: borderWidth*0.5, dy: borderWidth*0.5)
            ctx?.clip(to: rect)
            ctx?.draw(r, in: rect, byTiling: false)
            
            if let t=touchPoint {
                cursor?.draw(context: ctx, at: t, colour: currentColor.cgColor)
            }
        }
        
        ctx?.restoreGState()
    }
    
    
    
}

