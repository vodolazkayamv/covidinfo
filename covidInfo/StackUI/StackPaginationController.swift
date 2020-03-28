//
//  StackPaginationController.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class StackPaginationController: UIViewController {
    var superview : UIView
    
    var titleLabel : UILabel = UILabel()
    var pageController : UIPageControl = UIPageControl()
    var scrollView : UIScrollView = UIScrollView()
    
    var newsStacks : [ScrollableStackView] = []
    var pages = 3;
    
    var stackView : UIStackView = UIStackView();
    
    
    func setupPageControllerConstraints() {
        pageController.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            pageController.widthAnchor.constraint(equalTo:stackView.widthAnchor),
            pageController.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo:stackView.widthAnchor)
        ])
        
    }
    
    func setupStackViewViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0)
        ])
        
        let fillerView : UIView = UIView()
        stackView.insertArrangedSubview(fillerView, at: 0)
        NSLayoutConstraint.activate([
            fillerView.widthAnchor.constraint(equalTo:stackView.widthAnchor),
            fillerView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    init(superview: UIView, sources: [[String:String]]) {
        self.superview = superview;
        
        super.init(nibName: nil, bundle: nil)

        self.superview.addSubview(self.view)
        
        self.scrollView = UIScrollView(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 20, height: .zero))

        
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(pageController)
        stackView.addArrangedSubview(scrollView)
        stackView.axis = .vertical
        
        setupStackViewViewConstraints()
        setupTitleLabelConstraints()
        setupPageControllerConstraints()
        
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        //fill
        pages = sources.count
        for index in 0 ..< pages {
            let scrollableStack = ScrollableStackView();
            
            var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.origin.y = 0
            frame.size.width = UIScreen.main.bounds.width - 20
            frame.size.height = UIScreen.main.bounds.height - 40
            
            let firstStackView: UIView = UIView(frame: frame)
            firstStackView.layer.cornerRadius = 10
            scrollView.addSubview(firstStackView)
            
            scrollableStack.placeVerticalStackOnView(view: firstStackView)
            
            fill(newsStack: scrollableStack, withSource: sources[index]["link"]!)
            newsStacks.append(scrollableStack)
        }
        
        
        scrollView.contentSize = CGSize(width:  scrollView.frame.size.width * CGFloat(pages),
                                        height: scrollView.frame.size.height)
        configurePageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configurePageControl() {
        self.pageController.numberOfPages = self.pages
        self.pageController.currentPage = 0
        self.pageController.tintColor = UIColor.red
        self.pageController.pageIndicatorTintColor = UIColor.black
        self.pageController.currentPageIndicatorTintColor = UIColor.green
        
    }
    
    
    func fill(newsStack: ScrollableStackView, withSource: String){
        let newsURL: String = withSource;
        
        let feed : [RSS_Item] = loadData(urlString: newsURL)
        
        for item in feed {
            let newsCard: NewsCardView = NewsCardView(item: item)
            newsStack.addArrangedView(view: newsCard)
        }
    }
    
    
    func loadData(urlString: String) -> [RSS_Item] {
        let url = URL(string: urlString)!
        return loadRss(url);
    }
    
    func loadRss(_ data: URL) -> [RSS_Item]  {
        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        
        // Put feed in array.
        return myParser.feed()
    }
    
}
