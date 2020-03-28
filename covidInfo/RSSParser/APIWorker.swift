//
//  APIWorker.swift
//  covidInfo
//
//  Created by Мария Водолазкая on 28.03.2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation


struct COVIDStat : Decodable {
    let active, cases, critical, deaths, recovered, todayCases, todayDeaths: Int
    let country : String
    let deathsPerOneMillion, casesPerOneMillion : Float
    let countryInfo : CountryInfo
}

struct CountryInfo : Decodable {
    let _id : Int
    let lat, long : Int
    let flag, iso2, iso3 : String
}

class APIWorker {


    
    class func askCOVIDStatistics() {
        //guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=country") else {return}
        //https://corona.lmao.ninja/countries/Russia
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
                let result = try decoder.decode(COVIDStat.self, from: dataResponse)
                //let stats : [COVIDStat] = result.filter{ $0.country == "Russia" }

                print(result)
                NotificationCenter.default.post(name: .didReceiveData, object: result)


             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    
    
}
