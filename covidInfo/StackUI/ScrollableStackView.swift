//
//  ScrollableStackView.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 27.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class ScrollableStackView: UIScrollView {
    
    public var stackView:  UIStackView!
    
    func placeVerticalStackOnView(view: UIView) {
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        view.addSubview(self);
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        self.stackView = UIStackView();
        self.stackView.spacing = 10;
        self.stackView.axis = .vertical
        
        self.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    }
    
    func placeHorizontalStackOnView(view: UIView) {
        
        view.addSubview(self);
//        self.frame = view.bounds;
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        self.stackView = UIStackView();
        self.stackView.spacing = 10;
        self.stackView.axis = .vertical
        
        self.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

    }
    
    func fillWithStubsVertical() {
        for i in 1...10 {
            let rectangle = UIView()
            rectangle.translatesAutoresizingMaskIntoConstraints = false;
            rectangle.heightAnchor.constraint(equalToConstant: CGFloat(150 + i*10)).isActive = true
            rectangle.backgroundColor = .cyan
            
            self.stackView.addArrangedSubview(rectangle);
        }
    }
    
    func fillWithStubsHorizontal() {
        self.stackView.axis = .horizontal
        for i in 1...10 {
            let rectangle = UIView()
            rectangle.translatesAutoresizingMaskIntoConstraints = false;
            rectangle.widthAnchor.constraint(equalToConstant: CGFloat(15 + i*5)).isActive = true
            rectangle.backgroundColor = .systemPink
            
            self.stackView.addArrangedSubview(rectangle);
        }
    }
    
    func addArrangedViewWithHeight(view: UIView)  {
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        self.stackView.addArrangedSubview(view)
    }
    
    func addArrangedView(view: UIView)  {
        view.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.addArrangedSubview(view)
    }
    
}
