//
//  DTO.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 29/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation

struct COVIDStat : Decodable {
    let active, cases, critical, deaths, recovered, todayCases, todayDeaths: Int
    let country : String
    let deathsPerOneMillion, casesPerOneMillion : Float?
    let countryInfo : CountryInfo
}

struct CountryInfo : Decodable {
    let _id : Int?
    let lat, long : Float
    let flag, iso2, iso3 : String?
}

struct History : Decodable  {
    let country : String
    let timeline : Timeline
}

struct Timeline : Decodable  {
    let cases : [String:Int]
    let deaths : [String:Int]
}

struct Case {
    let date : Date
    let number: Int
}

struct HistoryDecoded {
    let country: String
    var casesHistory : [Case]
    var deathHistory : [Case]
}

class JHUCountryInfo : CustomStringConvertible {
    let country : String
    var statisticsToday : COVIDStat
    var history : HistoryDecoded
    
    init(today: COVIDStat, history: HistoryDecoded) {
        self.statisticsToday = today
        self.country = today.country
        
        self.history = history
    }
    
    init() {
        self.statisticsToday = COVIDStat(active: -1, cases: -1, critical: -1, deaths: -1, recovered: -1, todayCases: -1, todayDeaths: -1, country: "", deathsPerOneMillion: -1, casesPerOneMillion: -1, countryInfo: CountryInfo(_id: -1, lat: -1, long: -1, flag: "", iso2: "", iso3: ""))
        self.country = ""
        
        self.history = HistoryDecoded(country: "", casesHistory: [], deathHistory: [])
    }
    
    var casesDeviation : Int {
        get {
            if (self.history.casesHistory.count == 0) {
                return 0
            }
            if (self.history.casesHistory.count == 1) {
                return self.history.casesHistory[0].number
            }
            
            let yesterdayCases = self.history.casesHistory[0].number - self.history.casesHistory[1].number
            let todayCases = self.statisticsToday.todayCases
            
            return todayCases - yesterdayCases
        }
    }
    
    var deathDeviation : Int {
        get {
            if (self.history.deathHistory.count == 0) {
                return 0
            }
            if (self.history.deathHistory.count == 1) {
                return self.history.deathHistory[0].number
            }
            
            let yesterdayCases = self.history.deathHistory.first?.number
            let todayCases = self.statisticsToday.deaths
            
            return todayCases - (yesterdayCases ?? 0)
        }
    }
    
    var description: String {
        get {
            let desc = "\(history)"
            return desc
        }
    }
}
