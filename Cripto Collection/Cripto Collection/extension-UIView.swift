//
//  extension-UIView.swift
//  Cripto Collection
//
//  Created by Jin younkyum on 2022/04/18.
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
}
