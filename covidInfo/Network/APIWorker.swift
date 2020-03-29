//
//  APIWorker.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation

class APIWorker {


    class func askCOVIDStatisticsRussia() {
        askAPIvia(urlString: "https://corona.lmao.ninja/countries/Russia",
                  completionHandler: { dataResponse in
                    do{
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let today : COVIDStat = try decoder.decode(COVIDStat.self, from: dataResponse)
                        
                        askAPIvia(urlString: "https://corona.lmao.ninja/v2/historical/russia",
                                  completionHandler: { dataResponse in
                                    do{
                                        let decoder = JSONDecoder()
                                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                                        let result : History = try decoder.decode(History.self, from: dataResponse)

                                        var history : HistoryDecoded = HistoryDecoded(country: result.country, casesHistory: [], deathHistory: [])
                                        for item in result.timeline.cases {
                                            
                                            let isoDate = item.key
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "MM/dd/yy"
                                            let date = dateFormatter.date(from:isoDate)!
                                            
                                            let record : Case = Case(date: date, number: item.value)
                                            history.casesHistory.append(record)
                                        }
                                        for item in result.timeline.deaths {
                                            
                                            let isoDate = item.key
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "MM/dd/yy"
                                            let date = dateFormatter.date(from:isoDate)!
                                            
                                            let record : Case = Case(date: date, number: item.value)
                                            history.deathHistory.append(record)
                                        }
                                        history.casesHistory = history.casesHistory.sorted(by: {
                                            $0.date.compare($1.date) == .orderedDescending
                                        })
                                        history.deathHistory = history.deathHistory.sorted(by: {
                                            $0.date.compare($1.date) == .orderedDescending
                                        })
                                        
                                        let JHURussiaInfo : JHUCountryInfo = JHUCountryInfo(today: today, history: history)
                                        let dataDict:[String: JHUCountryInfo] = ["result": JHURussiaInfo]

                                        NotificationCenter.default.post(name: .didReceiveNativeCountryData, object: self, userInfo: dataDict)

                                        
                                    } catch let parsingError {
                                        print("Error", parsingError)
                                    }
                        })
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
        })
    }
    
    class func askCOVIDStatisticsAll() {
        askAPIvia(urlString: "https://corona.lmao.ninja/countries?sort=todayCases",
                  completionHandler: { dataResponse in
                    do{
//                        let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as AnyObject
//                        print(jsonResponse) //Response result
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let countries : [COVIDStat] = try decoder.decode([COVIDStat].self, from: dataResponse)
                        
                        for country in countries {
                            askAPIvia(urlString: "https://corona.lmao.ninja/v2/historical/" + country.country,
                                      completionHandler: { dataResponse in
                                        do{
                                            let decoder = JSONDecoder()
                                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                                            let result : History = try decoder.decode(History.self, from: dataResponse)

                                            var history : HistoryDecoded = HistoryDecoded(country: result.country, casesHistory: [], deathHistory: [])
                                            for item in result.timeline.cases {
                                                
                                                let isoDate = item.key
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "MM/dd/yy"
                                                let date = dateFormatter.date(from:isoDate)!
                                                
                                                let record : Case = Case(date: date, number: item.value)
                                                history.casesHistory.append(record)
                                            }
                                            for item in result.timeline.deaths {
                                                
                                                let isoDate = item.key
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "MM/dd/yy"
                                                let date = dateFormatter.date(from:isoDate)!
                                                
                                                let record : Case = Case(date: date, number: item.value)
                                                history.deathHistory.append(record)
                                            }
                                            history.casesHistory = history.casesHistory.sorted(by: {
                                                $0.date.compare($1.date) == .orderedDescending
                                            })
                                            history.deathHistory = history.deathHistory.sorted(by: {
                                                $0.date.compare($1.date) == .orderedDescending
                                            })
                                            
                                            let JHUSomeCountryInfo : JHUCountryInfo = JHUCountryInfo(today: country, history: history)
                                            let dataDict:[String: JHUCountryInfo] = ["result": JHUSomeCountryInfo]

                                            NotificationCenter.default.post(name: .didReceiveCountryData, object: self, userInfo: dataDict)
                                            
                                        } catch let parsingError {
                                            print("Error", parsingError)
                                        }
                            })

                        }
                        
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
        })
    }
    
    private class func askAPIvia(urlString:String, completionHandler: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else {return}

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            completionHandler(dataResponse)

        }
        task.resume()
    }
    
    class func askCOVIDStatisticsRussia_Actual() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries/Russia") else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
//                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as AnyObject
//                print(jsonResponse) //Response result

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result : COVIDStat = try decoder.decode(COVIDStat.self, from: dataResponse)
                //let stats : [COVIDStat] = result.filter{ $0.country == "Russia" }

                print(result)
                let dataDict:[String: COVIDStat] = ["result": result]

                NotificationCenter.default.post(name: .didReceiveNativeCountryData, object: self, userInfo: dataDict)


             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    
     class func askCOVIDStatisticsRussia_Historical() {
            guard let url = URL(string: "https://corona.lmao.ninja/v2/historical/russia") else {return}

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                      error == nil else {
                      print(error?.localizedDescription ?? "Response Error")
                      return }
                do{
                    //here dataResponse received from a network request
    //                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as AnyObject
    //                print(jsonResponse) //Response result

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result : History = try decoder.decode(History.self, from: dataResponse)
                    //let stats : [COVIDStat] = result.filter{ $0.country == "Russia" }

                    var h : HistoryDecoded = HistoryDecoded(country: result.country, casesHistory: [], deathHistory: [])
                    for item in result.timeline.cases {
                        
                        let isoDate = item.key
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        let date = dateFormatter.date(from:isoDate)!
                        
                        let record : Case = Case(date: date, number: item.value)
                        h.casesHistory.append(record)
                    }
                    h.casesHistory = h.casesHistory.sorted(by: {
                        $0.date.compare($1.date) == .orderedDescending
                    })
                    
                    print(result)
                    let dataDict:[String: History] = ["result": result]

                    NotificationCenter.default.post(name: .didReceiveNativeCountryData, object: self, userInfo: dataDict)


                 } catch let parsingError {
                    print("Error", parsingError)
               }
            }
            task.resume()
        }
}
