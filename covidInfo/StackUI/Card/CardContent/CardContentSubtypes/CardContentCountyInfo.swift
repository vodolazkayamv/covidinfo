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
    
    func fillWithJHUItem(item: JHUCountryInfo) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 5
        
        setTitle(item)
        setUpdatedTime(item)

        setCases(item)
        setActive(item)
        setCritical(item)
        setDeaths(item)
        setRecovered(item)
    }
    

    func setUpdatedTime(_ item:JHUCountryInfo) {
        if let update : Date = item.updated {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            formatter.locale = Locale.current
            
            let upstring = formatter.string(from: update)
            self.addArrangedLabelWith(text: upstring, font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light))
        }
    }
    
    func setTitle(_ item:JHUCountryInfo) {
        self.addArrangedLabelWith(text: item.country, font: UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.black))
    }
    
    func setCases(_ item: JHUCountryInfo)  {
        
        let casesString = "Выявлено: \(item.statisticsToday.cases)," + " сегодня: \(item.statisticsToday.todayCases)"
        let deviationString = (item.casesDeviation > 0
            ? "▲" + " \(item.casesDeviation)"
            : "▼" + " \(item.casesDeviation * (-1))")
        
        let casesAttrString = NSMutableAttributedString.init(string: casesString + " " + deviationString)
        (item.casesDeviation > 0
            ?
            casesAttrString.highlightRisingNeedleIn(haystack: casesAttrString.string, needle: deviationString)
            :
            casesAttrString.highlightDesendingNeedleIn(haystack: casesAttrString.string, needle: deviationString))
        self.addArrangedLabelWith(attributedText: casesAttrString)
    }
    
    func setDeaths(_ item: JHUCountryInfo)  {
        let deathString = "Погибли: \(item.statisticsToday.deaths)," + " сегодня: \(item.statisticsToday.todayDeaths)"
        let deviationString = (item.deathDeviation > 0
            ? "▲" + " \(item.deathDeviation)"
            : "▼" + " \(item.deathDeviation * (-1))")
        
        let deathAttrString = NSMutableAttributedString.init(string: deathString + " " + deviationString)
        (item.deathDeviation > 0
            ?
            deathAttrString.highlightRisingNeedleIn(haystack: deathAttrString.string, needle: deviationString)
            :
            deathAttrString.highlightDesendingNeedleIn(haystack: deathAttrString.string, needle: deviationString))
        self.addArrangedLabelWith(attributedText: deathAttrString)
    }
    
    func setActive(_ item: JHUCountryInfo)  {
        self.addArrangedLabelWith(text: "Всего заражённых сейчас: \(item.statisticsToday.active)")

    }
    
    func setCritical(_ item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string:"В критическом состоянии: \(item.statisticsToday.critical)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
    
    func setRecovered(_ item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string:"Выздоровели: \(item.statisticsToday.recovered)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
   
}
