//
//  PaddingView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class PaddingView: UIView {
    
    var padding : Int = 8;
    
    
    func setSubView(subview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        subview.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(subview);
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: -CGFloat(self.padding)),
            self.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: CGFloat(self.padding)),
            self.topAnchor.constraint(equalTo: subview.topAnchor, constant: -CGFloat(self.padding)),
            self.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: CGFloat(self.padding))
        ])
    }
    
}
