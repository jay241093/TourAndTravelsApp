//
//  UpdateProfileResponse.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/12/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let updateResponse = try? newJSONDecoder().decode(UpdateResponse.self, from: jsonData)

import Foundation

struct UpdateResponse: Codable {
    let data: DataClass5
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct DataClass5: Codable {
    let details: Details2
}

struct Details2: Codable {
    let id: Int
    let email, fname, lname, mobileNumber: String
    let profilePic: String
    let fcmToken: JSONNull?
    let status: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, fname, lname
        case mobileNumber = "mobile_number"
        case profilePic = "profile_pic"
        case fcmToken = "fcm_token"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
