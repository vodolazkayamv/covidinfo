//
//  CardStackView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CardStackView_RSS: CardStackView_General {
    
    var titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var descriptionLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var authorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var categoryLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var enclosureLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var guidLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var pubDateLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var sourceLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var contentLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    
    
    func fillWithRSSItem(item: RSS_Item) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 5
        
        
        setupTitleWith(item: item)
        setupDescriptionWith(item: item)
        setupPubDateWith(item: item)
        setupCategoryWith(item: item)
        
        showShortCard()

    }
    
    func setupTitleWith(item: RSS_Item){
        titleLabel.numberOfLines = 0
        titleLabel.text = item.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.sizeToFit()
        
        self.addArrangedSubview(titleLabel)
    }
    
    func setupDescriptionWith(item: RSS_Item){
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = NSAttributedString(html: item.itemDescription)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionLabel.sizeToFit()
        
        self.addArrangedSubview(descriptionLabel)

    }
    
    func setupAuthorWith(item: RSS_Item){
        authorLabel.numberOfLines = 0
        authorLabel.text = item.author
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        authorLabel.sizeToFit()
        
        self.addArrangedSubview(authorLabel)

    }
    
    func setupPubDateWith(item: RSS_Item){
        pubDateLabel.numberOfLines = 0
        pubDateLabel.text = item.pubDate
        pubDateLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        pubDateLabel.sizeToFit()
        
        self.addArrangedSubview(pubDateLabel)

    }
    
    func setupCategoryWith(item: RSS_Item){
        categoryLabel.numberOfLines = 0
        categoryLabel.text = item.category
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        categoryLabel.sizeToFit()
        
        self.addArrangedSubview(categoryLabel)

    }
    
    func setupContentWith(item: RSS_Item){
        contentLabel.numberOfLines = 0
        contentLabel.text = item.content
        contentLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        contentLabel.sizeToFit()
        
        self.addArrangedSubview(contentLabel)

    }
    
    func showShortCard() {
        titleLabel.isHidden = false
        pubDateLabel.isHidden = false
        descriptionLabel.isHidden = false
        categoryLabel.isHidden = false

        authorLabel.isHidden = true
        guidLabel.isHidden = true
        sourceLabel.isHidden = true
        contentLabel.isHidden = true
        enclosureLabel.isHidden = true
    }
    
}
