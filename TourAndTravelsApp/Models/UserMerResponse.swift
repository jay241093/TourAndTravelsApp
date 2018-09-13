
// To parse the JSON, add this file to your project and do:
//
//   let userMeResponse = try? newJSONDecoder().decode(UserMeResponse.self, from: jsonData)

import Foundation

struct UserMeResponse: Codable {
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
    let details: Details
    let favourites: [PackageListing]
}

struct Details: Codable {
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
