//
//  NewsCardView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    private let containerView : PaddingView = PaddingView();
    private let cardView : PaddingView = PaddingView();
    
    private func setupView() {
        containerView.setSubView(subview: cardView)

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10;
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.padding = 15;

        self.addSubview(containerView)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        setupView()
    }
    
    init(with content: CardContentView) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        setupView()
        
        cardView.setSubView(subview: content)
        
    }
    
    init(withRSS item: RSS_Item) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        
        setupView()
        
        let subStackView = CardContentRSSItem()
        subStackView.fillWithRSSItem(item: item)
        cardView.setSubView(subview: subStackView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
