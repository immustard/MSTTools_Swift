//
//  NumberMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import Foundation

extension Double {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int8 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int16 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension Int32 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension Int64 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt8 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt16 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension UInt32 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension UInt64 {
    public var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
