//
//  CardStackView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CardStackView: UIStackView {
    
    var titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var descriptionLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var authorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var categoryLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var enclosureLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var guidLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var pubDateLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var sourceLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var contentLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    

    init() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setConstraints()
    }
    
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
        
    }
    
    func setupDescriptionWith(item: RSS_Item){
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = NSAttributedString(html: item.itemDescription)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionLabel.sizeToFit()
    }
    
    func setupAuthorWith(item: RSS_Item){
        authorLabel.numberOfLines = 0
        authorLabel.text = item.author
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        authorLabel.sizeToFit()
    }
    
    func setupPubDateWith(item: RSS_Item){
        pubDateLabel.numberOfLines = 0
        pubDateLabel.text = item.pubDate
        pubDateLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        pubDateLabel.sizeToFit()
    }
    
    func setupCategoryWith(item: RSS_Item){
        categoryLabel.numberOfLines = 0
        categoryLabel.text = item.category
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        categoryLabel.sizeToFit()
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
    
    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(pubDateLabel)
        self.addArrangedSubview(descriptionLabel)
        self.addArrangedSubview(authorLabel)
        self.addArrangedSubview(categoryLabel)
        self.addArrangedSubview(guidLabel)
        self.addArrangedSubview(sourceLabel)
        self.addArrangedSubview(contentLabel)
        self.addArrangedSubview(enclosureLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        enclosureLabel.translatesAutoresizingMaskIntoConstraints = false
        guidLabel.translatesAutoresizingMaskIntoConstraints = false
        pubDateLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        
        titleLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        authorLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        enclosureLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        guidLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        pubDateLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        sourceLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        contentLabel.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
    }
}
