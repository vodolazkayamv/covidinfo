//
//  ViewController.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 27.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UIScrollViewDelegate {
    
    var pageController : UIPageControl = UIPageControl(frame: CGRect(x: 50, y: UIScreen.main.bounds.height - 20,
                                                                     width: 200, height: 20))
    

    var newsStacks : [ScrollableStackView] = []
    var myFeed : [RSS_Item] = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("HelloWorld")
        

        let pagingScrollView : UIScrollView = UIScrollView(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 20))
        pagingScrollView.delegate = self
        pagingScrollView.isPagingEnabled = true
        self.view.addSubview(pagingScrollView)
        
        let pages = 3;
        for index in 0..<pages {
            let scrollableStack = ScrollableStackView();
            
            var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
            frame.origin.x = pagingScrollView.frame.size.width * CGFloat(index)
            frame.origin.y = 0
            frame.size.width = UIScreen.main.bounds.width - 20
            frame.size.height = UIScreen.main.bounds.height - 40

            let firstStackView: UIView = UIView(frame: frame)
            firstStackView.layer.cornerRadius = 10
            pagingScrollView.addSubview(firstStackView)
            
            scrollableStack.placeVerticalStackOnView(view: firstStackView)
            
            newsStacks.append(scrollableStack)
        }
        
        pagingScrollView.contentSize = CGSize(width:  pagingScrollView.frame.size.width * CGFloat(pages),
                                              height: pagingScrollView.frame.size.height)
        
        
        
        
        self.configurePageControl()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<3 {
            var newsRSS_url: String = "";
            switch i {
            case 0:
                newsRSS_url = "https://www.who.int/feeds/entity/mediacentre/news/ru/rss.xml";
                break;
            case 1:
                newsRSS_url = "https://www.who.int/feeds/entity/csr/don/en/rss.xml";
                break;
            case 2:
                newsRSS_url = "https://www.ecdc.europa.eu/en/taxonomy/term/1310/feed";
                break;
            default:
                newsRSS_url = "";
            }
            
            loadData(urlString: newsRSS_url)
            
            for item in myFeed {
                let customView : PaddingView = PaddingView();
                let containerView : PaddingView = PaddingView()
                containerView.setSubView(subview: customView)

                customView.backgroundColor = .white
                customView.layer.cornerRadius = 10;
                
                customView.layer.shadowColor = UIColor.black.cgColor
                customView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                customView.layer.shadowOpacity = 0.2
                customView.layer.shadowRadius = 5.0
                
                let subStackView = CardStackView()
                subStackView.fillWithRSSItem(item: item)
                
                customView.padding = 15;
                customView.setSubView(subview: subStackView)

                self.newsStacks[i].addArrangedView(view: containerView)
            }
        }
        
    }
    
     func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    func loadData(urlString: String) {
        // https://www.who.int/feeds/entity/mediacentre/news/ru/rss.xml
        // https://www.who.int/feeds/entity/csr/don/en/rss.xml
        //url = URL(string: "https://www.ecdc.europa.eu/en/taxonomy/term/1310/feed")!
        url = URL(string: urlString)!

        loadRss(url);
    }
    
    func loadRss(_ data: URL) {
        
        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        
        // Put feed in array.
        myFeed = myParser.feed()
    }
    
    
    func configurePageControl() {
        self.pageController.numberOfPages = 3
        self.pageController.currentPage = 0
        self.pageController.tintColor = UIColor.red
        self.pageController.pageIndicatorTintColor = UIColor.black
        self.pageController.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageController)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
    }
}

