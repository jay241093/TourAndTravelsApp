//
//  HomeResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/11/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let homeResponse = try? newJSONDecoder().decode(HomeResponse.self, from: jsonData)

import Foundation

struct HomeResponse: Codable {
    let data: DataClass3
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct DataClass3: Codable {
    let hotDeals, featuredPackages, latestPackages: [PackageListing]
    
    enum CodingKeys: String, CodingKey {
        case hotDeals = "hot_deals"
        case featuredPackages = "featured_packages"
        case latestPackages = "latest_packages"
    }
}
