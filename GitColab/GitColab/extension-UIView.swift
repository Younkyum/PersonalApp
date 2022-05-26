//
//  extension-UIView.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit


extension UIView {
    @IBInspectable var conerRadius: CGFloat { // 모서리 둥글게
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            if let shadowColor = self.layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return UIColor.clear
        }
        
        set {
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var maskToBound: Bool {
        get {
            return self.layer.masksToBounds
        }
        
        set {
            self.layer.masksToBounds = newValue
        }
    }
}
