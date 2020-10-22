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
    let profession: String
    let bio: String
    let link1: String
    let link2: String
    let profileCreatedDate: Date
}

extension User {
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? "no id"
        self.name = dictionary["name"] as? String ?? "no name"
        self.email = dictionary["email"] as? String ?? "no email"
        self.username = dictionary["username"] as? String ?? "no username"
        self.location = dictionary["location"] as? String ?? "no location"
        self.profession = dictionary["profession"] as? String ?? "no profession"
        self.bio = dictionary["bio"] as? String ?? "no bio"
        self.link1 = dictionary["link1"] as? String ?? "no link"
        self.link2 = dictionary["link2"] as? String ?? "no link"
        self.profileCreatedDate = dictionary["profileCreatedDate"] as? Date ?? Date()
    }
}

