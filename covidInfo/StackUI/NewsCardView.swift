//
//  NewsCardView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class NewsCardView: UIView {
    
    init(item: RSS_Item) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        
        let containerView : PaddingView = PaddingView();

        let cardView : PaddingView = PaddingView();
        containerView.setSubView(subview: cardView)

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10;
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 5.0
        
        let subStackView = CardStackView()
        subStackView.fillWithRSSItem(item: item)
        
        cardView.padding = 15;
        cardView.setSubView(subview: subStackView)
        
        self.addSubview(containerView)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
