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
        ],
        [
        "title" : "CDC: Coronavirus Disease 2019 (COVID-19) Situation Update" ,
        "link"  : "https://tools.cdc.gov/api/v2/resources/media/404952.rss"
        ],
        [
        "title" : "CDC: Coronavirus Disease 2019 (COVID-19) Situation Update" ,
        "link"  : "https://tools.cdc.gov/api/v2/resources/media/404952.rss"
        ]
    ]
        
    var panelViewContoller : PanelViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("HelloWorld")
        
        self.view.backgroundColor = .systemGray6
        self.panelViewContoller = PanelViewController(superview: self.view)
        self.view.addSubview(panelViewContoller.view)
        
        createBoardsWith(sources: resources)
        
    }
    
    func createBoardsWith(sources: [[String:String]]) {
        
        for source in sources {
            let feed : [RSS_Item] = loadData(urlString: source["link"] ?? "")
            let board : BoardView = BoardView()
            for item in feed {
                let newsCard: CardView = CardView(withRSS: item)
                board.add(card: newsCard)
            }
            panelViewContoller.panelView.add(board: board)
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

