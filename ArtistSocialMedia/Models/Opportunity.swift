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
    let user: String
}
