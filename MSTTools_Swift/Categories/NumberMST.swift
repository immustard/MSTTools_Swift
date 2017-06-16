//
//  NumberMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import Foundation

extension Double {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int8 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Int16 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension Int32 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension Int64 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt8 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UInt16 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension UInt32 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
extension UInt64 {
    var mst_spellOut: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
