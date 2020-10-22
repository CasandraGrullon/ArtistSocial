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
