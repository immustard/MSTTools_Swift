//
//  StringMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// 字节长度
    var mst_byteLength: Int {
        return lengthOfBytes(using: .utf8)
    }
    
    /// 是否包含 emoji
    var mst_containEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 是否为空
    var mst_isEmpty: Bool {
        return (
            isEmpty ||
            self == "" ||
            self == "<null>" ||
            self == "(null)" ||
            self == "null"
        )
    }
    
    /// 去掉空白符是否为空
    var mst_isEmptyWithoutWhiteSpace: Bool {
        return (
            mst_isEmpty ||
            trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).mst_isEmpty
        )
    }
}

// MARK: - Calculate
extension String {
    /// 计算文字高度(label)
    ///
    /// - Parameters:
    ///   - width: 给定最大宽度
    ///   - font: 字体
    /// - Returns: 返回文字高度
    func mst_textHeight(maxWidth width: CGFloat, font: UIFont) -> CGFloat {
        let rect: CGRect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesDeviceMetrics, attributes: [NSFontAttributeName: font], context: nil)
        return rect.size.height + 2
    }
    
    /// 计算文字宽度(label)
    ///
    /// - Parameters:
    ///   - height: 给定最大高度
    ///   - font: 字体
    /// - Returns: 返回文字宽度
    func mst_textWidth(maxHeight height: CGFloat, font: UIFont) -> CGFloat {
        let rect: CGRect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesDeviceMetrics, attributes: [NSFontAttributeName: font], context: nil)
        return rect.size.width + 2
    }

    /// 计算文字高度(textView)
    ///
    /// - Parameters:
    ///   - textView: 展示文字的 UITextView
    ///   - width: 最大宽度
    /// - Returns: 返回展示高度
    func mst_textHeight(inTextView textView: UITextView, maxwidth width: CGFloat) -> CGFloat {
        let sizeToFit: CGSize = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        
        return sizeToFit.height
    }
}
