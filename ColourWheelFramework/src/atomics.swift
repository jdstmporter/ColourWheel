//
//  atomics.swift
//  ColourWheel
//
//  Created by Julian Porter on 17/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public class Atomic<T> {
    fileprivate static var queue : DispatchQueue { return DispatchQueue(label: "Atomic variable queue") }
    fileprivate var _value : T
    
    public init(_ raw : T) {
        self._value=raw
    }
    
    public var value : T {
        get { Atomic.queue.sync { self._value } }
        set { Atomic.queue.sync { self._value = newValue } }
    }
    
    public func apply(_ f : (T) -> T) -> T {
        return Atomic.queue.sync {
            self._value = f(self._value)
            return self._value
        }
    }
    public func testAndSet(test : (T) -> Bool,ifTrue: T?, ifFalse: T?) -> Bool {
        return Atomic.queue.sync {
            let result = test(self._value)
            if result, let tr = ifTrue { self._value=tr }
            else if !result, let fa = ifFalse { self._value = fa }
            return result
        }
    }
    
}

public protocol Flag {
    
    var isSet : Bool { get }
    func set()
    func clear()
    
    func testAndClear() -> Bool
}

public class SimpleFlag : Flag {
    private var value : Bool
    
    public init() { value = false }
    
    public var isSet : Bool { return self.value }
    public func set() { self.value=true }
    public func clear() { self.value=false }
    
    public func testAndClear() -> Bool {
        let v = self.value
        self.value = false
        return v
    }
}

public class AtomicFlag : Atomic<Bool>, Flag {
    
    public init() { super.init(false) }
    public override init(_ raw : Bool) { super.init(raw) }
    
    public var isSet : Bool { return self.value }
    public func set() { self.value=true }
    public func clear() { self.value=false }
    
    public func testAndClear() -> Bool {
        return AtomicFlag.queue.sync {
            let v = self._value
            self._value=false
            return v
        }
    }
}
