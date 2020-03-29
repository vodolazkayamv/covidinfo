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
        [ "title" : "Johns Hopkins Medicine science and medical news ",
          "link"  : "https://www.hopkinsmedicine.org/news/media/releases?format=rss"
        ],
        [
        "title" : "WHO Covid-19 News" ,
        "link"  : "https://www.who.int/rss-feeds/covid19-news-english.xml"
        ],
        [
        "title" : "CDC: Coronavirus Disease 2019 (COVID-19) Situation Update 1" ,
        "link"  : "https://tools.cdc.gov/api/v2/resources/media/404952.rss"
        ]
    ]
    
    var JHURussiaInfo : JHUCountryInfo = JHUCountryInfo()
        
    var panelViewContoller : PanelViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("HelloWorld")
        
        self.view.backgroundColor = .systemGray6
        self.panelViewContoller = PanelViewController(superview: self.view)
        self.view.addSubview(panelViewContoller.view)
        
        APIWorker.askCOVIDStatisticsRussia()

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: APIWorker.self)
    }
    
    func createBoardsWith(sources: [[String:String]]) {
        
        for source in sources {
            let feed : [RSS_Item] = loadData(urlString: source["link"] ?? "")
            let board : BoardView = BoardView()
            board.title = source["title"] ?? ""
            for item in feed {
                let newsCard: CardView = CardView(withRSS: item)
                board.add(card: newsCard)
            }
            panelViewContoller.add(board: board)
        }
    }
    
    // MARK: - RSS
    
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
    
    
    // MARK: - notifications
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: JHUCountryInfo]
        {
            for (key, value) in data
            {
                self.JHURussiaInfo = value
                
                DispatchQueue.main.async {
                    let majorBoard : BoardView = BoardView()

                    let novelCardContentView : CardContentCountyInfo = CardContentCountyInfo()
                    novelCardContentView.fillWithJHUItem(item: value)

                    let novelCard : CardView = CardView(with: novelCardContentView)
                    
                    majorBoard.add(card: novelCard)
                    majorBoard.addCopyrightLabelWith(text: "Data obtained from Coronavirus COVID-19 Global Cases by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University (JHU)")
                    
                    self.panelViewContoller.add(board: majorBoard)
                    
                    //self.createBoardsWith(sources: self.resources)
                }
            }
        }
    }
    
}

