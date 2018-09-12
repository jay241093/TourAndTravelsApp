//
//  LoginResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/27/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation

struct LoginResponse: Codable {
    let data: login
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct login: Codable {
    let id, otp: Int
    let mobileNumber, fname, lname, email: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id, otp
        case mobileNumber = "mobile_number"
        case fname, lname, email, token
    }
}
