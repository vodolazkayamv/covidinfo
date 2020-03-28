//
//  PanelView.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 28/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class PanelView: UIView {
    
    // MARK: - properties

    var boards : [BoardView] = []
    var scrollView : UIScrollView = UIScrollView(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width, height: .zero))

    public var pages : Int {
        get {
            return boards.count;
        }
    }
    
    // MARK: - initializers
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
    }
    
    // MARK: - add

    public func add(board: BoardView) {
        
        let newBoardIndex = boards.count
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)

        let spacing : CGFloat = 10
        let offsetX = (boards.last?.frame.origin.x ?? 0)
        let previousWidth = (boards.last?.frame.size.width ?? 0)
        
        let inset = newBoardIndex == 0 ? spacing : offsetX
        let offset = newBoardIndex == 0 ? 0 : 2*spacing
        frame.origin.x =  inset + previousWidth + offset;
        frame.origin.y = 0
        
        // TODO: make boards resize for album orientation
        frame.size.width = UIScreen.main.bounds.width - spacing*2
        frame.size.height = UIScreen.main.bounds.height
        board.frame = frame
        
        scrollView.addSubview(board)
        boards.append(board)

        var size : CGSize = scrollView.contentSize
        size.width += board.frame.size.width + spacing * 2
        size.height = 0
        scrollView.contentSize = size

    }
    
}
