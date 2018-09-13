//
//  ThemeList.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/7/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let themeList = try? newJSONDecoder().decode(ThemeList.self, from: jsonData)


import Foundation

struct ThemeList: Codable {
    let data: [Theme]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct Theme: Codable {
    let id: Int
    let name: String
    let description: String?
}
