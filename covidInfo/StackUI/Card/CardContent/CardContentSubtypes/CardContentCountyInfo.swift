//
//  CardContentCountyInfo.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 29/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CardContentCountyInfo: CardContentView {
    
    var titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var descriptionLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var authorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var categoryLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var enclosureLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var guidLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var pubDateLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var sourceLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    var contentLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: Int.max))
    
    
    func fillWithJHUItem(item: JHUCountryInfo) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 5
        
        setTitle(item: item)
        setCases(item: item)
//        setActive(item: item)
        setCritical(item: item)
        setDeaths(item: item)
        setRecovered(item: item)
    }
    
    func setTitle(item:JHUCountryInfo) {
        self.addArrangedLabelWith(text: item.country, font: UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.black))
    }
    
    func setCases(item: JHUCountryInfo)  {
        
        let casesString = "Выявлено: \(item.statisticsToday.cases)," + " сегодня: \(item.statisticsToday.todayCases)"
        let deviationString = (item.casesDeviation > 0 ? "▲" : "▼") + " \(item.casesDeviation)"
        let casesAttrString = NSMutableAttributedString.init(string: casesString + " " + deviationString)
        (item.casesDeviation > 0
            ?
            casesAttrString.highlightRisingNeedleIn(haystack: casesAttrString.string, needle: deviationString)
            :
            casesAttrString.highlightDesendingNeedleIn(haystack: casesAttrString.string, needle: deviationString))
        self.addArrangedLabelWith(attributedText: casesAttrString)
    }
    
    func setDeaths(item: JHUCountryInfo)  {
        let deathString = "Погибли: \(item.statisticsToday.deaths)," + " сегодня: \(item.statisticsToday.todayDeaths)"
        let deviationString = (item.deathDeviation > 0 ? "▲" : "▼") + " \(item.deathDeviation)"
        let deathAttrString = NSMutableAttributedString.init(string: deathString + " " + deviationString)
        (item.deathDeviation > 0
            ?
            deathAttrString.highlightRisingNeedleIn(haystack: deathAttrString.string, needle: deviationString)
            :
            deathAttrString.highlightDesendingNeedleIn(haystack: deathAttrString.string, needle: deviationString))
        self.addArrangedLabelWith(attributedText: deathAttrString)
    }
    
    func setActive(item: JHUCountryInfo)  {
        self.addArrangedLabelWith(text: "Активны: \(item.statisticsToday.active)")

    }
    
    func setCritical(item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string:"В критическом состоянии: \(item.statisticsToday.critical)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
    
    func setRecovered(item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string:"Выздоровели: \(item.statisticsToday.recovered)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
   
}
