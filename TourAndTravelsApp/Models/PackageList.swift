//
//  PackageList.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/29/18.
//  Copyright © 2018 Ravi Dubey. All rights reserve


import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let userMeResponse = try? newJSONDecoder().decode(UserMeResponse.self, from: jsonData)

import Foundation

struct PackageList: Codable {
    let data: [PackageListing]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

struct PackageListing: Codable {
    let id: Int
    let userID, primaryImage, agencyID, name: String
    let mobileName, totalDays, totalNights, price: String?
    let discountPrice, startDate, endDate, cities: String?
    let description, longDescription, termsConditions, cancellationPolicy: String?
    var isFavourite: Bool
    let categories, tags: String
    let packageIty: [PackageIty]
    let packageImages: [PackageImage]
    let allCities: [AllCity]
    var packageReviews: [PackageReview]
    let agency: Agency
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case primaryImage = "primary_image"
        case agencyID = "agency_id"
        case name
        case mobileName = "mobile_name"
        case totalDays = "total_days"
        case totalNights = "total_nights"
        case price
        case discountPrice = "discount_price"
        case startDate = "start_date"
        case endDate = "end_date"
        case cities, description
        case longDescription = "long_description"
        case termsConditions = "terms_conditions"
        case cancellationPolicy = "cancellation_policy"
        case isFavourite = "is_favourite"
        case categories, tags
        case packageIty = "package_ity"
        case packageImages = "package_images"
        case allCities = "all_cities"
        case packageReviews = "package_reviews"
        case agency
    }
}

struct Agency: Codable {
    let id: Int
    let name, ownerName, contactPersonName, email: String
    let designation, mobileNumber, whatsappNumber, website: String
    let address, branchAddress, description, logo: String
    let addressProof: String
    let gstProof, pancardProof: JSONNull?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case ownerName = "owner_name"
        case contactPersonName = "contact_person_name"
        case email, designation
        case mobileNumber = "mobile_number"
        case whatsappNumber = "whatsapp_number"
        case website, address
        case branchAddress = "branch_address"
        case description, logo
        case addressProof = "address_proof"
        case gstProof = "gst_proof"
        case pancardProof = "pancard_proof"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct AllCity: Codable {
    let id: Int
    let packageID, city, stayNights, createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case packageID = "package_id"
        case city
        case stayNights = "stay_nights"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct PackageImage: Codable {
    let id: Int
    let packageID, path: String
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case packageID = "package_id"
        case path
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



struct PackageIty: Codable {
    let id: Int
    let day, title, text, inclusions: String
    let imagePath, packageID: String
    let hotelID, flightID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, day, title, text, inclusions
        case imagePath = "image_path"
        case packageID = "package_id"
        case hotelID = "hotel_id"
        case flightID = "flight_id"
    }
}

struct PackageReview: Codable {
    let id: Int
    let packageID, rating, title, text: String
    let name, status, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case packageID = "package_id"
        case rating, title, text, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: Encode/decode helpers
