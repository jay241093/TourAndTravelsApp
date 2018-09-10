//
//  CityResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/29/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import Foundation

struct CityResponse: Codable {
    let data: [City]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct City: Codable {
    let id: Int
    let cityName, stateName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityName = "city_name"
        case stateName = "state_name"
    }
}
