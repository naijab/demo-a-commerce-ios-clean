//
//  UIViewExtension.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 9/6/2564 BE.
//

import UIKit

extension UIView {
    func applyBorderRadius(size: CGFloat = 9) {
        self.layer.cornerRadius = size
    }
    
    func applyShadow(size: CGFloat = 9) {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = size
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
