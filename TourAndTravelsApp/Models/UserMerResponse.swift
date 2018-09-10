// To parse the JSON, add this file to your project and do:
//
//   let userMerResponse = try? newJSONDecoder().decode(UserMerResponse.self, from: jsonData)

import Foundation

struct UserMerResponse: Codable {
    let data: DataClass2
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct DataClass2: Codable {
    let details: Details
    let favourites: [Favourite]
}

struct Details: Codable {
    let id: Int
    let email, fname, lname, mobileNumber: String?
    let profilePic, fcmToken: String?
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

struct Favourite: Codable {
    let id: Int
    let name: String
    let mobileName, userID, agencyID: Int
    let categoryID: String?
    let totalDays, totalNights, price, discountPrice: Int
    let cities, description, startDate, endDate: String?
    let longDescription, primaryImage, termsConditions, cancellationPolicy: String?
    let status: Int
    let viewsCount: String?
    let isComplete, isApprove, isTgApprove: Int?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case mobileName = "mobile_name"
        case userID = "user_id"
        case agencyID = "agency_id"
        case categoryID = "category_id"
        case totalDays = "total_days"
        case totalNights = "total_nights"
        case price
        case discountPrice = "discount_price"
        case cities, description
        case startDate = "start_date"
        case endDate = "end_date"
        case longDescription = "long_description"
        case primaryImage = "primary_image"
        case termsConditions = "terms_conditions"
        case cancellationPolicy = "cancellation_policy"
        case status
        case viewsCount = "views_count"
        case isComplete = "is_complete"
        case isApprove = "is_approve"
        case isTgApprove = "is_tg_approve"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
