//
//  pixels.swift
//  Swifted
//
//  Created by Julian Porter on 21/12/2018.
//  Copyright © 2018 Justin Meiners. All rights reserved.
//

import UIKit

public struct RGBPixel {
    public let bytes : [UInt8]
    
    public init() {
        self.init(0,0,0)
    }
    public init(_ rr: UInt8,_ gg: UInt8, _ bb: UInt8) {
        self.init([rr,gg,bb])
    }
    public init(_ rgb : [UInt8]) {
        bytes=Array(rgb.prefix(3))
    }
    
    public var r : UInt8 { return bytes[0] }
    public var g : UInt8 { return bytes[1] }
    public var b : UInt8 { return bytes[2] }
    public var color : UIColor {
        let rgb = bytes.map { CGFloat($0)/255.0 }
        return UIColor(red: rgb[0], green: rgb[1], blue: rgb[2] , alpha: 1)
    }
    
    public init(_ c : UIColor) {
        var rr : CGFloat=0
        var gg : CGFloat=0
        var bb : CGFloat=0
        var aa : CGFloat=0
        c.getRed(&rr, green: &gg, blue: &bb, alpha: &aa)
        self.init(UInt8(255*rr),UInt8(255*gg),UInt8(255*bb))
    }
    
    
    
}



public struct HSVPixel {
    
    internal static let mixers : [Int:[Int]] = [
        0 : [0,2,1],
        1 : [3,0,1],
        2 : [1,0,2],
        3 : [1,3,0],
        4 : [2,1,0],
        5 : [0,1,3]
    ]
    
    public let h : CGFloat
    public let s : CGFloat
    public let v : CGFloat
    
    public init(_ hh : CGFloat,_ ss: CGFloat,_ vv : CGFloat) {
        h=hh
        s=ss
        v=vv
    }
    
    public init(_ c : UIColor) {
        var hh : CGFloat=0
        var ss : CGFloat=0
        var vv : CGFloat=0
        var aa : CGFloat=0
        c.getHue(&hh, saturation: &ss, brightness: &vv, alpha: &aa)
        self.init(hh,ss,vv)
    }
    
    public init(polar p : Polar, brightness : CGFloat) {
        h=(p.theta/(2*CGFloat.pi)).bound(min:0,max:1-0.0000001)
        s=p.r.bound(min:0,max:1)
        v=brightness
    }

    
    
    public var bytes : [UInt8] {
        let hh=h*6
        let i = Swift.min(5,Int(hh))
        let f = hh-floor(hh)
        let vptq = [v,v*(1-s),v*(1-s*(1-f)),v*(1-s*f)]
        return HSVPixel.mixers[i]!.map { UInt8(vptq[$0]*255) }
    }
    
    public var rgb : RGBPixel {
        return RGBPixel(bytes)
    }
    
    public var ui : UIColor {
        return UIColor(hue: h, saturation: s, brightness: v, alpha: 1)
    }
    
    public var polar : Polar {
        return Polar(r: s,theta: CGFloat.pi*(2*h+0.5))
    }
    
    public func quantised(_ quantiser: ColourQuantisation) -> HSVPixel {
        let newHSV = quantiser.quantise([h,s,v])
        return HSVPixel(newHSV[0], newHSV[1], newHSV[2])
    }
    
   
    
}

