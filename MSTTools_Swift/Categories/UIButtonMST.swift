//
//  UIButtonMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import UIKit



/**
 设置按钮图片和文字的布局方式，以及之间的间距
 在布局之后调用
 
 @param style 布局方式
 @param space 间距
 */

extension UIButton {
    public enum MSTButtonEdgeOfImageStyle {
        case top            // 图片在上，文字在下
        case left           // 图片在左，文字在右
        case bottom         // 图片在下，文字在上
        case right          // 图片在右，文字在左
    }
    
    /// 设置按钮图片和文字的布局方式，以及之间的间距
    /// 在布局之后调用
    ///
    /// - Parameters:
    ///   - style: 布局方式
    ///   - space: 间距
    public func mst_layoutButton(style: MSTButtonEdgeOfImageStyle, spaceBetweenImageAndTitle space: CGFloat) {
        // 1. 得到imageView和titleLabel的宽、高
        let imageWidth: CGFloat = imageView?.frame.size.width ?? 0
        let imageHeight: CGFloat = imageView?.frame.size.height ?? 0
        
        var labelWidth: CGFloat = 0
        var labelHeight: CGFloat = 0
        
        if #available(iOS 8.0, *) {
            // 由于iOS8中titleLabel的size为0，用下面的这种设置
            labelWidth = titleLabel?.intrinsicContentSize.width ?? 0
            labelHeight = titleLabel?.intrinsicContentSize.height ?? 0
        } else {
            labelWidth = titleLabel?.frame.size.width ?? 0
            labelHeight = titleLabel?.frame.size.height ?? 0
        }
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space/2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space/2.0, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space/2.0, bottom: 0, right: -labelWidth - space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space/2.0, bottom: 0, right: imageWidth + space/2.0)
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
}
