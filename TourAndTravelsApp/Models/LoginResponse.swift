//
//  LoginResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/27/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let data: DataClass
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct DataClass: Codable {
    let fname, lname, mobileNumber, email: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case fname, lname
        case mobileNumber = "mobile_number"
        case email, token
    }
}
