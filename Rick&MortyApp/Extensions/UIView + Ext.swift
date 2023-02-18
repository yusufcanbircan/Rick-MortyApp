//
//  UIView + Ext.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 18.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
