//
//  PackageList.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/29/18.
//  Copyright © 2018 Ravi Dubey. All rights reserve
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
    let id, userID: Int
    let primaryImage: String
    let agencyID: Int
    let name, mobileName: String
    let totalDays, totalNights, price, discountPrice: Int
    let startDate, endDate, cities, description: String?
    let longDescription, termsConditions, cancellationPolicy: String
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
    let name, email: String
}

struct AllCity: Codable {
    let id, packageID: Int
    let city: String
    let stayNights: Int
    let createdAt, updatedAt: String
    
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
    let id, packageID: Int
    let path: String
    let createdAt, updatedAt: AtedAt
    
    enum CodingKeys: String, CodingKey {
        case id
        case packageID = "package_id"
        case path
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum AtedAt: String, Codable {
    case the20180910130118 = "2018-09-10 13:01:18"
    case the20180910145722 = "2018-09-10 14:57:22"
    case the20180911112939 = "2018-09-11 11:29:39"
}

struct PackageIty: Codable {
    let id, day: Int
    let title, text, inclusions, imagePath: String
    let packageID: Int
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
    var id, packageID: Int
    var rating:Double
    var title, text, name: String
    var status: Int
    var createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case packageID = "package_id"
        case rating, title, text, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
