//
//  Portfolio.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/22/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct Portfolio: Codable {
    let id: String
    let image: String
    let description: String
    let tags: [String]
    let yearCompleted: String
    let postedDate: Date
}
extension Portfolio {
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? "no id"
        self.image = dictionary["image"] as? String ?? "no image url"
        self.description = dictionary["description"] as? String ?? "no description"
        self.tags = dictionary["tags"] as? [String] ?? []
        self.yearCompleted = dictionary["yearCompleted"] as? String ?? "no year provided"
        self.postedDate = dictionary["postedDate"] as? Date ?? Date()
    }
}
