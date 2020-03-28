//
//  BoardView.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 28/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class BoardView: UIView {
    var title: String = ""
    var cards : [CardView] = []
    private var cardsScrollableStackView : ScrollableStackView!
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        super.init(frame: frame)
        
        cardsScrollableStackView = ScrollableStackView(superview: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func add(card: CardView) {
        cards.append(card)
        cardsScrollableStackView.addArrangedView(view: card)
    }
    public func add(card: CardView, at: Int) {
        cards.append(card)
        cardsScrollableStackView.addArrangedView(view: card, at: at)
    }
    public func add(card: CardView, aboveCard: CardView) {
        cards.append(card)
        cardsScrollableStackView.addArrangedView(view: card, aboveSubview: aboveCard)
    }
    public func add(card: CardView, belowCard: CardView) {
        cards.append(card)
        cardsScrollableStackView.addArrangedView(view: card, aboveSubview: belowCard)
    }
    
    
    
}
