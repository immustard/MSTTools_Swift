//
//  UILabelMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import UIKit

extension UILabel {
    public func mst_addLongPressCopyMenu() {
        isUserInteractionEnabled = true
        
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mp_showCopyMenu))
        addGestureRecognizer(longPress)
    }
    
    @objc private func mp_showCopyMenu() {
        becomeFirstResponder()
        
        UIMenuController.shared.setTargetRect(frame, in: superview!)
        UIMenuController.shared.setMenuVisible(self.isFirstResponder, animated: true)
    }
    
    open override var canBecomeFocused: Bool {
        return true
    }
    
    // 可以响应的方法
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
    // 针对于响应方法的实现
    open override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
}
