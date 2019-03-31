//
//  geometry.swift
//  Swifted
//
//  Created by Julian Porter on 21/12/2018.
//  Copyright © 2018 Justin Meiners. All rights reserved.
//

import UIKit

public struct Polar {
    public let r : CGFloat
    public let theta : CGFloat
    
    public init(r : CGFloat,theta: CGFloat) {
        self.r=r
        self.theta=theta
    }
    public init(_ p : CGPoint) {
        r=p.length
        theta=atan2(p.x,p.y)+CGFloat.pi
    }
    
    public var point : CGPoint { return CGPoint(x: r*cos(theta), y: r*sin(theta))}
    public static func *(_ l : Polar,_ s: CGFloat) -> Polar { return Polar(r: l.r*s, theta: l.theta) }
    public static func /(_ l : Polar,_ s: CGFloat) -> Polar { return Polar(r: l.r/s, theta: l.theta) }
    
}

extension CGPoint {
    public var length : CGFloat { return sqrt(x*x+y*y) }
    public static func -(_ l : CGPoint, _ r : CGPoint) -> CGPoint { return CGPoint(x: l.x-r.x,y: l.y-r.y) }
    public static func +(_ l : CGPoint, _ r : CGPoint) -> CGPoint { return CGPoint(x: l.x+r.x,y: l.y+r.y) }
    public static func ||(_ l : CGPoint, _ r : CGPoint) -> CGFloat { return (l-r).length }
    public static func *(_ l : CGPoint,_ r : CGFloat) -> CGPoint { return CGPoint(x:l.x*r,y:l.y*r) }
    
    
}

extension CGSize {
    public var mid : CGPoint { return CGPoint(x : width*0.5, y : height*0.5) }
    public static func *(_ l : CGSize,_ r : CGFloat) -> CGSize { return CGSize(width:l.width*r,height:l.height*r) }
    public var min : CGFloat { return Swift.min(width,height) }
    
    public init(side : CGFloat) {
        self.init(width: side, height: side)
    }
    public init(boxed: CGSize) {
        self.init(side: boxed.min)
    }
}

extension CGRect {
    public var mid : CGPoint { return size.mid }
}

extension CGFloat {
    public func bound(min: CGFloat,max:CGFloat) -> CGFloat { return Swift.min(max,Swift.max(min,self)) }
}
