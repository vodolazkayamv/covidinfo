//
//  ViewController.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 27.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet var stackView: UIStackView!
    
    
    var myFeed : [RSS_Item] = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("HelloWorld")
        

        let myView: UIView = UIView(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 20))
        myView.layer.cornerRadius = 10
        self.view.addSubview(myView)
        
        let scrollableStack = ScrollableStackView();
        scrollableStack.placeVerticalStackOnView(view: myView)
        
        loadData()
        
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
            
            
            let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: Int.max))
            titleLabel.numberOfLines = 0
            titleLabel.text = item.title
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.sizeToFit()
            
            let descriptionLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: Int.max))
            descriptionLabel.numberOfLines = 0
            descriptionLabel.attributedText = NSAttributedString(html: item.itemDescription)
            descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.sizeToFit()
            
            let subStackView: UIStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
            subStackView.translatesAutoresizingMaskIntoConstraints = false
            subStackView.axis = .vertical
            subStackView.spacing = 5
            
            titleLabel.widthAnchor.constraint(equalTo:subStackView.widthAnchor).isActive = true
            descriptionLabel.widthAnchor.constraint(equalTo:subStackView.widthAnchor).isActive = true
            
            customView.padding = 15;
            customView.setSubView(subview: subStackView)
            
            

            scrollableStack.addArrangedView(view: containerView)
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
    
    func loadData() {
        // https://www.who.int/feeds/entity/mediacentre/news/ru/rss.xml
        // https://www.who.int/feeds/entity/csr/don/en/rss.xml
        //url = URL(string: "https://www.ecdc.europa.eu/en/taxonomy/term/1310/feed")!
        url = URL(string: "https://www.who.int/feeds/entity/csr/don/en/rss.xml")!

        loadRss(url);
    }
    
    func loadRss(_ data: URL) {
        
        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        
        // Put feed in array.
        myFeed = myParser.feed()
    }
    
}

