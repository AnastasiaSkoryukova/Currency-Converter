//
//  UIView+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 30.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}
