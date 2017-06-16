//
//  UIViewMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import UIKit

// MARK: - Frame
extension UIView {
    var mst_top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var mst_left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var mst_right: CGFloat {
        get {
            return mst_left + mst_width
        }
        set {
            mst_left = newValue - mst_width
        }
    }
    
    var mst_bottom: CGFloat {
        get {
            return mst_top + mst_width
        }
        set {
            mst_top = newValue - mst_height
        }
    }
    
    var mst_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var mst_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var mst_mstCenterX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var mst_mstCenterY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    var mst_origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    var mst_size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
}

// MARK: - Subview
extension UIView {
    /// 根据 tag 获得子视图
    func mst_subview(tag: Int) -> UIView? {
        return self.viewWithTag(tag)
    }
    
    /// 删除所有子视图
    func mst_removeAllSubviews() {
        while subviews.count > 0 {
            let subview = subviews.first
            subview?.removeFromSuperview()
        }
    }
    
    
    /// 根据 tag 删除子视图
    func mst_removeSubview(tag: Int) {
        guard tag != 0 else { return }

        let subview = mst_subview(tag: tag)
        subview?.removeFromSuperview()
    }
    
    /// 根据 tags 删除多个子视图
    func mst_removeSubviews(tags: Array<Int>) {
        for tag in tags {
            mst_removeSubview(tag: tag)
        }
    }
    
    /// 删除比该 tag 小的视图
    func mst_removeSubviewLessThan(tag: Int) {
        var views: Array<UIView> = []
        for subview in subviews {
            if subview.tag != 0 && subview.tag < tag {
                views.append(subview)
            }
        }
        mp_removeSubviews(views: views)
    }
    
    /// 删除比该 tag 大的视图
    func mst_removeSubviewGreaterThan(tag: Int) {
        var views: Array<UIView> = []
        for subview in subviews {
            if subview.tag != 0 && subview.tag > tag {
                views.append(subview)
            }
        }
        mp_removeSubviews(views: views)
    }
    
    private func mp_removeSubviews(views: Array<UIView>) {
        for view in views {
            view.removeFromSuperview()
        }
    }
}

// MARK: - View Controller
extension UIView {
    /// 得到该视图所在的视图控制器
    func mst_responderViewController() -> UIViewController? {
        var next:UIView? = self
        
        repeat {
            if let nextResponder = next?.next, nextResponder.isKind(of: UIViewController.self) {
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        } while next != nil
        
        return nil
    }
}

// MARK: - Draw Rect
extension UIView {
    /// 设置圆形
    func mst_circular() {
        mst_cornerRadius(radius: mst_width/2.0)
    }
    
    /// 设置圆角
    func mst_cornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// 设置某几个角为圆角
    func mst_corners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath: UIBezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    /// 设置圆角线框
    func mst_addBorder(radius: CGFloat, lineWidth width: CGFloat, lineColor color: UIColor) {
        mst_cornerRadius(radius: radius)
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

// MARK: - Gesture
extension UIView {
    func mst_addTapGesture(target: Any?, action: Selector?) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(tap)
    }
}
