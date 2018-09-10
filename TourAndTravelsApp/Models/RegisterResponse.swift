//
//  RegisterResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/27/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import Foundation

struct RegisterResponse: Codable {
    let data: RegisterClass
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct RegisterClass: Codable {
    let fname, lname, email, mobileNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case fname, lname, email
        case mobileNumber = "mobile_number"
    }
}
