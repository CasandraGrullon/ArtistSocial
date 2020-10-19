//
//  Post.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

struct Post: Codable {
    let id: String
    let userName: String
    let userProfilePicture: String
    let datePosted: Date
    let postText: String
    let postImage: String
    let comments: [Post]
}
