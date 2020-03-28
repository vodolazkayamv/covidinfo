//
//  CardStackView_General.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CardStackView_General: UIStackView {
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setConstraints()
    }
    
    
    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.axis = .vertical
        self.spacing = 5
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
    }
}
