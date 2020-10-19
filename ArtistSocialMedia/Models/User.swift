//
//  User.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let username: String
    let location: String
    let portfolio: [Portfolio]
    let profession: String
    let bio: String
    let link1: String
    let link2: String
    let isFollowing: Bool
}
struct Portfolio: Codable {
    let id: String
    let image: String
    let description: String
    let tags: [String]
    let yearCompleted: String
    let postedDate: Date
}
