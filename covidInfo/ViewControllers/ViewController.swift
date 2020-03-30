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
        [ "title" : "\nJohns Hopkins Medicine science and medical news ",
          "link"  : "https://www.hopkinsmedicine.org/news/media/releases?format=rss"
        ],
        [
        "title" : "\nWHO Covid-19 News" ,
        "link"  : "https://www.who.int/rss-feeds/covid19-news-english.xml"
        ],
        [
        "title" : "\nCDC: Coronavirus Disease 2019 (COVID-19) Situation Update 1" ,
        "link"  : "https://tools.cdc.gov/api/v2/resources/media/404952.rss"
        ]
    ]
        
    var panelViewContoller : PanelViewController!
    var majorBoard : BoardView = BoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = .systemYellow
        print("Hello COVID-19 Info!")
        
        //self.view.backgroundColor = .systemGray6
        self.panelViewContoller = PanelViewController(superview: self.view)
        self.view.addSubview(panelViewContoller.view)
        
        APIWorker.askCOVIDStatisticsAll()
        
        majorBoard = BoardView()
        majorBoard.title = "\nDaily COVID-19 Global Cases Report"
        self.panelViewContoller.add(board: majorBoard)
        self.majorBoard.addCopyrightLabelWith(text: "Data obtained from Coronavirus COVID-19 Global Cases by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University (JHU)")

        //self.createBoardsWith(sources: resources)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDataNative(_:)), name: .didReceiveNativeCountryData, object: APIWorker.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveCountryData, object: APIWorker.self)
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    
    func createBoardsWith(sources: [[String:String]]) {
        
        let serialQueue = DispatchQueue(label: "news_queue")
        serialQueue.async {
            for source in sources {
                let feed : [RSS_Item] = self.loadData(urlString: source["link"] ?? "")
                DispatchQueue.main.async {
                    let board : BoardView = BoardView()
                    board.title = source["title"] ?? ""
                    for item in feed {
                        let newsCard: CardView = CardView(withRSS: item)
                        board.add(card: newsCard)
                    }
                    self.panelViewContoller.add(board: board)
                }
            }
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
    @objc func onDidReceiveDataNative(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: JHUCountryInfo]
        {
            for (_, value) in data
            {
                DispatchQueue.main.async {

                    let novelCardContentView : CardContentCountyInfo = CardContentCountyInfo()
                    novelCardContentView.fillWithJHUItem(item: value)

                    let novelCard : CardView = CardView(with: novelCardContentView)
                    
                    self.majorBoard.add(card: novelCard, at: 0)
                    
                    
                }
            }
        }
    }
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: JHUCountryInfo]
        {
            for (_, value) in data
            {
                DispatchQueue.main.async {

                    let novelCardContentView : CardContentCountyInfo = CardContentCountyInfo()
                    novelCardContentView.fillWithJHUItem(item: value)
                    let novelCard : CardView = CardView(with: novelCardContentView)
                    
                    let locale = Locale.current
                    let currentRegion = locale.regionCode?.lowercased() ?? ""
                    
                    if currentRegion == value.statisticsToday.countryInfo.iso2?.lowercased() {
                        self.majorBoard.add(card: novelCard, at: 0)
                    } else {
                        self.majorBoard.add(card: novelCard)
                    }
                }
            }
        }
    }
    
}

