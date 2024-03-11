//
//  CALayer+Extension.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import UIKit

extension CALayer {
    func addShadowEffect() {
        self.shadowColor = UIColor.gray.cgColor
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = 1.0
        self.shadowRadius = 7.0
        self.masksToBounds =  false
    }
    
    func addCornerRadius(radius: CGFloat) {
        self.cornerRadius = radius
    }
}
