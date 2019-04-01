//
//  colours.swift
//  ColourWheelFramework
//
//  Created by Julian Porter on 01/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension CGFloat {
    public func quantise(step: Int) -> CGFloat {
        let fStep = CGFloat(step)
        return floor(self*fStep)/fStep
    }
}

extension Array {
    static func zip<T,U>(_ l : [T], _ r : [U]) -> [(T,U)] {
        let n = Swift.min(l.count,r.count)
        return (0..<n).map { (l[$0],r[$0]) }
    }
}

public struct ColourQuantisation {
    public let nBits : UInt
    private let counts : [Int]
    
    
    
    public init() {
        self.init(bits: 8)
    }
    
    public init(bits: UInt) {
        let n : Int = 1<<bits
        nBits=bits
        counts=[n,n,n]
    }
    
    
    
    public func quantise(_ hsv: [CGFloat]) -> [CGFloat] {
        return Array<Any>.zip(hsv,counts).map { $0.0.quantise(step: $0.1) }
    }
    public func quantise(_ v : CGFloat) -> CGFloat {
        return v.quantise(step: counts[2])
    }
    
    
    
    
}

class ColourSource {
    private let quantisation : ColourQuantisation
    private let quantise : Bool
    
    public init(bits : UInt = 0) {
        self.quantisation=ColourQuantisation(bits: bits)
        self.quantise=bits>0
    }
    
    public func colour(polar: Polar,brightness: CGFloat) -> HSVPixel {
        let pix = HSVPixel(polar: polar, brightness: brightness)
        return quantise ? pix.quantised(quantisation) : pix
    }
    public func colour(_ h : CGFloat,_ s : CGFloat,_ v : CGFloat) -> HSVPixel {
        let pix = HSVPixel(h,s,v)
        return quantise ? pix.quantised(quantisation) : pix
    }
    
    
    public var nBits : UInt { return quantisation.nBits }
}

