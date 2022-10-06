//
//  Model.swift
//  SwiftUItest
//
//  Created by Линар Нигматзянов on 04/10/2022.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Decodable, Identifiable {
    var id: Int?
    let searchMetadata: SearchMetadata
    let searchParameters: SearchParameters
    let searchInformation: SearchInformation
    let shoppingResults: [ShoppingResult]?
    let suggestedSearches: [SuggestedSearch]?
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case searchInformation = "search_information"
        case shoppingResults = "shopping_results"
        case suggestedSearches = "suggested_searches"
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Decodable,Identifiable {
    let id: Int
    let thumbnail: String
    let source, title: String
    let link: String
    let original: String
    let isProduct: Bool
    let inStock: Bool?

    enum CodingKeys: String, CodingKey {
        case thumbnail, source, title, link, original
        case id = "position"
        case isProduct = "is_product"
        case inStock = "in_stock"
    }
}

// MARK: - SearchInformation
struct SearchInformation: Decodable {
    let imageResultsState, queryDisplayed: String
    let menuItems: [MenuItem]?
    
    enum CodingKeys: String, CodingKey {
        case imageResultsState = "image_results_state"
        case queryDisplayed = "query_displayed"
        case menuItems = "menu_items"
    }
}

// MARK: - MenuItem
struct MenuItem: Decodable {
    let position: Int
    let title: String
    let link: String?
    let serpapiLink: String?

    enum CodingKeys: String, CodingKey {
        case position, title, link
        case serpapiLink = "serpapi_link"
    }
}

// MARK: - SearchMetadata
struct SearchMetadata: Decodable {
    let id, status: String
    let jsonEndpoint: String
    let createdAt, processedAt: String
    let googleURL: String
    let rawHTMLFile: String
    let totalTimeTaken: Double

    enum CodingKeys: String, CodingKey {
        case id, status
        case jsonEndpoint = "json_endpoint"
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case googleURL = "google_url"
        case rawHTMLFile = "raw_html_file"
        case totalTimeTaken = "total_time_taken"
    }
}

// MARK: - SearchParameters
struct SearchParameters: Decodable {
    let engine, q, googleDomain, ijn: String
    let device, tbm: String

    enum CodingKeys: String, CodingKey {
        case engine, q
        case googleDomain = "google_domain"
        case ijn, device, tbm
    }
}

// MARK: - ShoppingResult
struct ShoppingResult: Decodable {
    let position: Int
    let link: String
}

// MARK: - SuggestedSearch
struct SuggestedSearch: Decodable {
    let name: String?
    let link: String?
    let chips: String?
    let serpapiLink: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case name, link, chips
        case serpapiLink = "serpapi_link"
        case thumbnail
    }
}
