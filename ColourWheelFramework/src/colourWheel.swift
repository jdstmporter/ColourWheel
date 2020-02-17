//
//  ISColorWheel.swift
//  Swifted
//
//  Created by Julian Porter on 20/12/2018.
//  Copyright © 2018 Justin Meiners. All rights reserved.
//

import UIKit







public typealias ColorWheelChangeCallback = (ColorWheel) -> Void



public class ColorWheel : UIControl {
    public var delegate : ColorWheelChangeCallback? = nil
    public var cursorSize : CGSize = CGSize(width: 42, height: 42)
    public var brightness : CGFloat = 1
    public var continuous : Bool = false
    public var borderColor : UIColor = .black
    public var borderWidth : CGFloat = 3
    
    private var cursor : Cursor!
    private var radialImage : CGImage?
    private var imageData : [UInt8] = []
    private var radiusDidChange : Bool = false
    private var radius : CGFloat = 0 {
        didSet {
            radiusDidChange = radius != oldValue
            cen=CGPoint(x: radius, y: radius)
            width=Int(2*radius)
            height=width
            wheelSize=CGSize(width: width, height: height)
        }
    }
    private var touchPoint : CGPoint!
    private var cen : CGPoint!
    private var mid : CGPoint!
    
    private var width : Int!
    private var height : Int!
    private var wheelSize : CGSize!
    
    private var colours : ColourSource!
    
    public var nBits : UInt {
        get { return colours?.nBits ?? 0 }
        set { colours = ColourSource(bits: newValue) }
    }
    
    internal func initialise() {
        backgroundColor = .clear
        mid=bounds.mid
        touchPoint=mid
        cursor=Cursor(size: cursorSize, borderWidth: borderWidth)
        colours=ColourSource()
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
    
    
    
    private func colorAtPoint(_ x: Int,_ y: Int) -> [UInt8] {
        return colorAtPoint(CGPoint(x: x, y: y))
    }
        
    private func colorAtPoint(_ point : CGPoint) -> [UInt8] {
        let dp=Polar(point-cen)/radius
        return colours.colour(polar: dp,brightness: brightness).bytes
    }
    
    private func viewToImageSpace(_ point : CGPoint) -> CGPoint {
        let min=mid-cen
        return CGPoint(x: point.x,y:bounds.height-point.y)-min
    }
    
    
    private func updateImage() {
        if bounds.width==0 || bounds.height==0 { return }
        if !radiusDidChange { return }
        radiusDidChange=false
        radialImage=nil
        
        let dataLength = 3*width*height
        imageData=Array<UInt8>(repeating: 0, count: dataLength)
        
        var offset : Int = 0
        (0..<height).forEach { y in
            (0..<width).forEach { x in
                imageData.replaceSubrange(offset..<(offset+3), with: colorAtPoint(x,y))
                offset+=3
            }
        }
        if let provider=CGDataProvider(dataInfo: nil,data: &imageData,size: dataLength,releaseData: { (_,_,_) in }) {
            radialImage=CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 24, bytesPerRow: width*3,
                                space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: .byteOrderMask, provider: provider,
                                decode: nil, shouldInterpolate: true, intent: .defaultIntent)
        }
        setNeedsDisplay()
    }

    public var currentColor : UIColor {
        get {
            return RGBPixel(colorAtPoint(viewToImageSpace(touchPoint))).color
        }
        set {
            let hsv=HSVPixel(newValue)
            brightness=hsv.v
            let polar=hsv.polar*radius
            setTouchPoint(cen + polar.point)
            updateImage()
        }
    }
    
    private func setBrightness(_ b : CGFloat) {
        brightness=b
        updateImage()
        delegate?(self)
    }
    
     public func setTouchPoint(_ point : CGPoint) {
        let vec=point-bounds.mid
        if vec.length < radius { touchPoint=point }
        else {
            let scaled=vec*(radius/vec.length)
            touchPoint=mid+scaled
        }
        setNeedsDisplay()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t=touches.first {
            setTouchPoint(t.location(in: self))
            delegate?(self)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t=touches.first {
            setTouchPoint(t.location(in: self))
            if continuous { delegate?(self) }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        mid=bounds.mid
        radius=0.5*Swift.min(bounds.width,bounds.height)-Swift.max(0,borderWidth)
        updateImage()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ctx=UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        
        let wheelFrame=CGRect(origin: mid-cen,size: wheelSize)
        let borderFrame=wheelFrame.insetBy(dx: -0.5*borderWidth, dy: -0.5*borderWidth)
        if borderWidth>0 {
            ctx?.setLineWidth(borderWidth)
            ctx?.setStrokeColor(borderColor.cgColor)
            ctx?.addEllipse(in: borderFrame)
            ctx?.strokePath()
        }
        ctx?.addEllipse(in: wheelFrame)
        ctx?.clip()
        if let r=radialImage {
            ctx?.draw(r, in: wheelFrame, byTiling: false)
        }
        
        if let p=touchPoint {
            cursor?.draw(context: ctx, at: p, colour: currentColor.cgColor)
        }
        ctx?.restoreGState()
    }
}
