//
//  PanelViewController.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 28/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class PanelViewController: UIViewController, UIScrollViewDelegate {
    
    let titleContainerView : UIView = UIView()
    let titleLabel: UILabel = UILabel()
    
    let structureView : UIStackView = UIStackView()
    let panelView : PanelView = PanelView()
    var pageController : UIPageControl = UIPageControl()
    
    init(superview: UIView) {
        super.init(nibName: nil, bundle: nil)
        
        superview.addSubview(self.view)
        self.view.addSubview(structureView)
        
        self.structureView.axis = .vertical
        self.structureView.spacing = 0
        
        self.structureView.addArrangedSubview(titleContainerView)
        self.structureView.addArrangedSubview(pageController)
        self.structureView.addArrangedSubview(panelView)
        
        titleLabel.text = ""
        setupConstraints(superview)
        configurePageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panelView.scrollView.delegate = self
    }
    
    func setupConstraints(_ superview:UIView) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        structureView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            structureView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            structureView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            structureView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            structureView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        pageController.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            pageController.widthAnchor.constraint(equalTo:structureView.widthAnchor),
            pageController.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleContainerView.widthAnchor.constraint(equalTo:structureView.widthAnchor),
        ])
        titleContainerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo:titleContainerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo:titleContainerView.trailingAnchor, constant: -20),
            titleContainerView.heightAnchor.constraint(equalTo:titleLabel.heightAnchor),

        ])
    }
    // MARK: - page control
    func configurePageControl() {
        self.pageController.numberOfPages = panelView.pages
        self.pageController.currentPage = 0
        self.pageController.tintColor = UIColor.systemRed
        self.pageController.pageIndicatorTintColor = UIColor.systemGray
        self.pageController.currentPageIndicatorTintColor = UIColor.systemGreen
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber : Int = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageController.currentPage = pageNumber
        titleLabel.text = panelView.boards[pageNumber].title
    }
    
    // MARK: -
     public func add(board: BoardView) {
        self.panelView.add(board: board)
        configurePageControl()
        
        if panelView.boards.count == 1 {
            self.titleLabel.text = panelView.boards[0].title
        }
    }
    
    // MARK: - notifications
    
}
