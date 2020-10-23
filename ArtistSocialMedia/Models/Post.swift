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
}
extension Post {
    init (_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? "no id"
        self.userName = dictionary["userName"] as? String ?? "no username"
        self.userProfilePicture = dictionary["userProfilePicture"] as? String ?? "no userProfilePicture"
        self.datePosted = dictionary["datePosted"] as? Date ?? Date()
        self.postText = dictionary["postText"] as? String ?? "no text"
        self.postImage = dictionary["postImage"] as? String ?? "no image"
    }
}
