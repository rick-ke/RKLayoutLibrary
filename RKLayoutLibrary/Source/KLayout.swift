//
//  KLayout.swift
//  KLayout
//
//  Created by Rick Ke on 2017/12/20.
//  Copyright © 2017年 RickKe. All rights reserved.
//

import UIKit


public enum KLayoutPriority: Float {
    case required = 1000  // 預設就是1000
    case high     = 750
    case medium   = 500
    case low      = 250
}


extension UIView {
    
    /// 基礎版
    /// 閉包處理的layoutConstraint
    func makeLayout(_ closure: (_ make: UIView) -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        closure(self)
    }
    
    /// 進階版
    /// 閉包處理的layoutConstraint, 編譯程式碼可以省略makeLayout這一行了
    func addSubview(_ subview: UIView, _ closure: (_ make: UIView) -> Void) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        closure(subview)
    }
    
    /// 最FreeStyle的用法
    @discardableResult
    func kLayout(_ att1: NSLayoutAttribute, _ related: NSLayoutRelation, to item: UIView?, _ att2: NSLayoutAttribute) -> NSLayoutConstraint {
        let layout = NSLayoutConstraint(item        : self,
                                        attribute   : att1,
                                        relatedBy   : related,
                                        toItem      : item,
                                        attribute   : att2,
                                        multiplier  : 1,
                                        constant    : 0)
        layout.isActive = true
        return layout
    }
    
    /// 一般用於：等於其他view的屬性
    @discardableResult
    func kLayout(_ att1: NSLayoutAttribute, equalTo item: UIView?, _ att2: NSLayoutAttribute) -> NSLayoutConstraint {
        let layout = NSLayoutConstraint(item        : self,
                                        attribute   : att1,
                                        relatedBy   : .equal,
                                        toItem      : item,
                                        attribute   : att2,
                                        multiplier  : 1,
                                        constant    : 0)
        layout.isActive = true
        return layout
    }
    
    /// 一般用於：對齊上、對齊下、對齊左、對齊右 或 等寬、等高
    @discardableResult
    func kLayout(_ att: NSLayoutAttribute, equalTo item: UIView) -> NSLayoutConstraint {
        return kLayout(att, .equal, to: item, att)
    }
    
    /// 一般用於：高為多少 或 寬為多少
    @discardableResult
    func kLayout(_ att: NSLayoutAttribute, equalBy constant: CGFloat) -> NSLayoutConstraint {
        return kLayout(att, .equal, to: nil, att).const(constant)
    }
    
    /// 高與寬各為多少
    func kLayoutSize(_ size: CGSize) {
        kLayout(.width , equalBy: size.width)
        kLayout(.height, equalBy: size.height)
    }
    
    /// 寬高比為多少，寬 = 高 X 係數
    func kLayoutHorizontalRatio(_ ratio: CGFloat) {
        kLayout(.width, .equal, to: self, .height).multi(ratio)
    }
    
    /// 高寬比為多少，高 = 寬 X 係數
    func kLayoutVerticalRatio(_ ratio: CGFloat) {
        kLayout(.height, .equal, to: self, .width).multi(ratio)
    }
    
    /// 中心點對齊
    func kLayoutCenter(equalTo item: UIView) {
        kLayout(.centerX, equalTo: item)
        kLayout(.centerY, equalTo: item)
    }
    
    /// 寬度對齊
    func kLayoutWidth(equalTo item: UIView) {
        kLayout(.left, equalTo: item)
        kLayout(.right, equalTo: item)
    }
    
    /// 高度對齊
    func kLayoutHeight(equalTo item: UIView) {
        kLayout(.top, equalTo: item)
        kLayout(.bottom, equalTo: item)
    }
    
    /// 寬度與高度都對齊
    func kLayoutWall(equalTo item: UIView) {
        kLayoutWidth(equalTo: item)
        kLayoutHeight(equalTo: item)
    }
    
    /// 內縮尺寸
    func kLayoutInsets(_ insets: UIEdgeInsets, to item: UIView) {
        kLayout(.top   , equalTo: item).inset(insets.top)
        kLayout(.left  , equalTo: item).inset(insets.left)
        kLayout(.bottom, equalTo: item).inset(insets.bottom)
        kLayout(.right , equalTo: item).inset(insets.right)
    }
    
    /// 外推尺寸
    func kLayoutOffsets(_ offsets: UIEdgeInsets, to item: UIView) {
        kLayout(.top   , equalTo: item).offset(offsets.top)
        kLayout(.left  , equalTo: item).offset(offsets.left)
        kLayout(.bottom, equalTo: item).offset(offsets.bottom)
        kLayout(.right , equalTo: item).offset(offsets.right)
    }
    
}


extension NSLayoutConstraint {
    
    /**
     layout的優先權
     * required = 1000  // 預設就是1000
     * high     = 750
     * medium   = 500
     * low      = 250
     */
    @discardableResult
    func priority(_ priority: KLayoutPriority) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: priority.rawValue)
        return self
    }
    
    /// layout的優先權
    @discardableResult
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    /// 常數
    @discardableResult
    func const(_ const: CGFloat) -> NSLayoutConstraint {
        self.constant = const
        return self
    }
    
    /// 外推長度
    @discardableResult
    func offset(_ const: CGFloat) -> NSLayoutConstraint {
        switch firstAttribute {
        case .right, .bottom:
            self.constant = const
        case .left, .top:
            self.constant = -const
        default:
            break
        }
        return self
    }
    
    /// 內縮長度
    @discardableResult
    func inset(_ const: CGFloat) -> NSLayoutConstraint {
        switch firstAttribute {
        case .right, .bottom:
            self.constant = -const
        case .left, .top:
            self.constant = const
        default:
            break
        }
        return self
    }
    
    /// 倍數
    @discardableResult
    func multi(_ multi: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else { fatalError("沒有目標物件") }
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item        : firstItem,
            attribute   : firstAttribute,
            relatedBy   : relation,
            toItem      : secondItem,
            attribute   : secondAttribute,
            multiplier  : multi,
            constant    : constant)
        
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
    
}
