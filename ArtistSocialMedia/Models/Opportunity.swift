//
//  Opportunity.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

struct Opportunity: Codable {
    let id: String
    let type: String
    let title: String
    let detail: String
    let location: String
    let email: String
    let phoneNumber: String
    let link: String
    let datePosted: Date
    let userID: String
}
extension Opportunity {
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? "no id"
        self.type = dictionary["type"] as? String ?? "no type"
        self.title = dictionary["title"] as? String ?? "no title"
        self.detail = dictionary["detail"] as? String ?? "no details"
        self.location = dictionary["location"] as? String ?? "no location"
        self.email = dictionary["email"] as? String ?? "no email"
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? "no phone number"
        self.link = dictionary["link"] as? String ?? "no link"
        self.datePosted = dictionary["datePosted"] as? Date ?? Date()
        self.userID = dictionary["userID"] as? String ?? "no user id"
    }
}
