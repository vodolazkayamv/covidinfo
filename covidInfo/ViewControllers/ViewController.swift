//
//  ViewController.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 27.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UIScrollViewDelegate {
    
    let resources : [[String:String]] = [
        [
        "title" : "WHO Covid-19 News" ,
        "link"  : "https://www.who.int/rss-feeds/covid19-news-english.xml"
        ],
        [
        "title" : "CDC: Coronavirus Disease 2019 (COVID-19) Situation Update" ,
        "link"  : "https://tools.cdc.gov/api/v2/resources/media/404952.rss"
        ]
    ]
    
    var pagingScrollView : StackPaginationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("HelloWorld")
        
        self.pagingScrollView = StackPaginationController(superview: self.view, sources: resources)
        self.pagingScrollView.scrollView.delegate = self
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber : Int = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pagingScrollView.pageController.currentPage = pageNumber
        
        if pageNumber < resources.count {
            pagingScrollView.titleLabel.text = resources[pageNumber]["title"]
        }
    }
    
}

