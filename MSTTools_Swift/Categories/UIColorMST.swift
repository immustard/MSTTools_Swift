//
//  UIColorMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/15.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import UIKit

extension UIColor {
    public static var mst_RandomColor: UIColor {
        return mst_RGBColor(r: CGFloat(arc4random()%256)/255, g: CGFloat(arc4random()%256)/255, b: CGFloat(arc4random()%256)/255)
    }
    
    public class func mst_RGBColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return mst_RGBAColor(r: r, g: g, b: b, a: 1)
    }
    
    public class func mst_RGBAColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
