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
        self.spacing = 15
        
        setTitle(item)
//        setUpdatedTime(item)
        
        let infoCards : UIStackView = UIStackView()
        self.addArrangedSubview(infoCards)
        infoCards.axis = .horizontal
        infoCards.spacing = 5
        infoCards.distribution = .fillEqually
        
        infoCards.addArrangedSubview(setupCasesCard(item))
        infoCards.addArrangedSubview(setupDeathsCard(item))
        infoCards.addArrangedSubview(setupRecoveredCard(item))

//        setCases(item)
//        setActive(item)
//        setCritical(item)
//        setDeaths(item)
//        setRecovered(item)
    }
    

    func setUpdatedTime(_ item:JHUCountryInfo) -> UILabel {
        if let update : Date = item.updated {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            formatter.locale = Locale.current
            
            let upstring = formatter.string(from: update)
            
            let label : UILabel = UILabel()
            label.numberOfLines = 0
            label.text = upstring
            label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light)
            label.sizeToFit()
            
            return label
            //self.addArrangedLabelWith(text: upstring, font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light))
        }
        return UILabel()
    }
    
    func setTitle(_ item:JHUCountryInfo) {
        
        let countrySV : UIStackView = UIStackView()
        countrySV.axis = .horizontal
        countrySV.spacing = 20
        
        let titleSV : UIStackView = UIStackView()
        titleSV.axis = .vertical
        titleSV.spacing = 0
        
        let label : UILabel = UILabel()
        label.numberOfLines = 0
        label.text = item.country
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.black)
        label.sizeToFit()
        
        titleSV.addArrangedSubview(label);
        titleSV.addArrangedSubview(setUpdatedTime(item))
        
        countrySV.addArrangedSubview(titleSV)
        
        if let countryCode = item.statisticsToday.countryInfo.iso2?.lowercased() {
            let flagImage : UIImage = UIImage(named: countryCode) ?? UIImage()
            let flagImageView : UIImageView = UIImageView(image: flagImage)
            flagImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            flagImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            flagImageView.dropShadow()
            
            flagImageView.contentMode = .scaleAspectFit
            countrySV.addArrangedSubview(flagImageView);
        } else {
            Logger.warning("country missing iso2 code: \(item.country)")
        }
        
        
        self.addArrangedSubview(countrySV)
    }
    
    /*
     
     Family: Avenir Font names: ["Avenir-Oblique", "Avenir-HeavyOblique", "Avenir-Heavy", "Avenir-BlackOblique", "Avenir-BookOblique", "Avenir-Roman", "Avenir-Medium", "Avenir-Black", "Avenir-Light", "Avenir-MediumOblique", "Avenir-Book", "Avenir-LightOblique"]
     Family: Avenir Next Font names: ["AvenirNext-Medium", "AvenirNext-DemiBoldItalic", "AvenirNext-DemiBold", "AvenirNext-HeavyItalic", "AvenirNext-Regular", "AvenirNext-Italic", "AvenirNext-MediumItalic", "AvenirNext-UltraLightItalic", "AvenirNext-BoldItalic", "AvenirNext-Heavy", "AvenirNext-Bold", "AvenirNext-UltraLight"]
     Family: Avenir Next Condensed Font names: ["AvenirNextCondensed-Heavy", "AvenirNextCondensed-MediumItalic", "AvenirNextCondensed-Regular", "AvenirNextCondensed-UltraLightItalic", "AvenirNextCondensed-Medium", "AvenirNextCondensed-HeavyItalic", "AvenirNextCondensed-DemiBoldItalic", "AvenirNextCondensed-Bold", "AvenirNextCondensed-DemiBold", "AvenirNextCondensed-BoldItalic", "AvenirNextCondensed-Italic", "AvenirNextCondensed-UltraLight"]
     
     */
    
    func initTitleLabel(title:String) -> UILabel {
        let label : UILabel = labelWith(font: "AvenirNext-DemiBold", size: 20)
        label.text = title
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    func initValueLabel(value:String) -> UILabel {
        let label : UILabel = labelWith(font: "AvenirNext-Medium", size: 16)
        label.text = value
        label.adjustsFontSizeToFitWidth  = true

        return label
    }
    
    func initTodayLabelFor(_ value: Int, deviation: Int) -> UILabel {
        
        let label : UILabel = labelWith(font: "AvenirNext-UltraLight", size: 14)
        label.numberOfLines = 0
        let deviationString = (deviation > 0
            ? "▲" + "\(deviation)"
            : "▼" + "\(deviation * (-1))")
        
        let casesAttrString = NSMutableAttributedString.init(string: "\(value)" + " " + deviationString)
        (deviation > 0
            ?
            casesAttrString.highlightRisingNeedleIn(haystack: casesAttrString.string, needle: deviationString)
            :
            casesAttrString.highlightDesendingNeedleIn(haystack: casesAttrString.string, needle: deviationString))
        
        label.attributedText = casesAttrString
        
        return label
        
    }
    
    func labelWith(font: String, size: CGFloat) -> UILabel {
        let label : UILabel = UILabel()
        if let customFont = UIFont(name: font, size: size) {
            label.font = customFont
        } else {
            Logger.error("Could not load font \(font)")
            label.font = UIFont.systemFont(ofSize: size)
        }
        
        label.textAlignment = .center
        
        return label
    }
    
    func setupCasesCard(_ item: JHUCountryInfo) -> PaddingView {
        let card : PaddingView = PaddingView()
        
        card.padding = 5
        card.backgroundColor = .pastelCasesBackground
        card.layer.cornerRadius = 10
        
        let cardContent : UIStackView = UIStackView()
        cardContent.axis = .vertical
        cardContent.spacing = 0
        card.setSubView(subview: cardContent)

        let titleLabel : UILabel = initTitleLabel(title: "cases".localized())
        titleLabel.textColor = UIColor.pastelCasesFont
        cardContent.addArrangedSubview(titleLabel)

        let valueLabel : UILabel = initValueLabel(value: "\(item.statisticsToday.cases)")
        cardContent.addArrangedSubview(valueLabel)

        let todayValueLabel : UILabel = initTodayLabelFor(item.statisticsToday.todayCases, deviation: item.casesDeviation)
        cardContent.addArrangedSubview(todayValueLabel)
        
        return card;
    }
    
    func setupDeathsCard(_ item: JHUCountryInfo) -> PaddingView {
        let card : PaddingView = PaddingView()
        
        card.padding = 5
        card.backgroundColor = .pastelDeathBackground
        card.layer.cornerRadius = 10
        
        let cardContent : UIStackView = UIStackView()
        cardContent.axis = .vertical
        cardContent.spacing = 0
        card.setSubView(subview: cardContent)

        let titleLabel : UILabel = initTitleLabel(title: "deaths".localized())
        titleLabel.textColor = UIColor.pastelDeathFont
        cardContent.addArrangedSubview(titleLabel)

        let valueLabel : UILabel = initValueLabel(value: "\(item.statisticsToday.deaths)")
        cardContent.addArrangedSubview(valueLabel)

        let todayValueLabel : UILabel = initTodayLabelFor(item.statisticsToday.todayDeaths, deviation: item.deathDeviation)
        cardContent.addArrangedSubview(todayValueLabel)
        
        return card;
    }
    
    func setupRecoveredCard(_ item: JHUCountryInfo) -> PaddingView {
        let card : PaddingView = PaddingView()
        
        card.padding = 5
        card.backgroundColor = .pastelRecoveredBackground
        card.layer.cornerRadius = 10
        
        let cardContent : UIStackView = UIStackView()
        cardContent.axis = .vertical
        cardContent.spacing = 0
        card.setSubView(subview: cardContent)

        let titleLabel : UILabel = initTitleLabel(title: "recovered".localized())
        titleLabel.textColor = UIColor.pastelRecoveredFont
        cardContent.addArrangedSubview(titleLabel)

        let valueLabel : UILabel = initValueLabel(value: "\(item.statisticsToday.recovered)")
        cardContent.addArrangedSubview(valueLabel)

        
        
        return card;
    }
    
    func setCases(_ item: JHUCountryInfo)  {
        
        let casesString = "cases".localized() +  ": \(item.statisticsToday.cases), " + "today".localized() + ": \(item.statisticsToday.todayCases)"
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
        let deathString = "deaths".localized() + ": \(item.statisticsToday.deaths), " + "today".localized() + ": \(item.statisticsToday.todayDeaths)"
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
        self.addArrangedLabelWith(text: "active".localized() + ": \(item.statisticsToday.active)")

    }
    
    func setCritical(_ item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string: "critical".localized() + ": \(item.statisticsToday.critical)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
    
    func setRecovered(_ item: JHUCountryInfo)  {
        let casesString = NSMutableAttributedString.init(string: "recovered".localized() + ": \(item.statisticsToday.recovered)")
        self.addArrangedLabelWith(attributedText: casesString)

    }
   
}
