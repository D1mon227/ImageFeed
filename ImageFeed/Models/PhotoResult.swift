//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 17.04.2023.
//

import Foundation

struct PhotoResult: Codable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let description: String
    let urls: UrlsResult
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case width = "width"
        case height = "height"
        case description = "description"
        case urls = "urls"
    }
}

struct UrlsResult: Codable {
    let full: String?
    let thumb: String?
}
