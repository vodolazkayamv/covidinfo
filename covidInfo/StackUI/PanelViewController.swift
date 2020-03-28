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
    
    let structureView : UIStackView = UIStackView()
    let panelView : PanelView = PanelView()
    var pageController : UIPageControl = UIPageControl()
    
    init(superview: UIView) {
        super.init(nibName: nil, bundle: nil)
        
        superview.addSubview(self.view)
        self.view.addSubview(structureView)
        self.structureView.addArrangedSubview(panelView)
        
        setupConstraints(superview)
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
    }
    // MARK: - page control
    func configurePageControl() {
        self.pageController.numberOfPages = panelView.pages
        self.pageController.currentPage = 0
        self.pageController.tintColor = UIColor.red
        self.pageController.pageIndicatorTintColor = UIColor.black
        self.pageController.currentPageIndicatorTintColor = UIColor.green
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber : Int = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageController.currentPage = pageNumber
    }
}
