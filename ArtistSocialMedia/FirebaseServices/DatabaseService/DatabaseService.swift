//
//  DatabaseService.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    public static let shared = DatabaseService()
    private init() {}
    
    //collections
    static let userCollection = "users"
    static let postsCollection = "posts"
    static let opportunitiesCollection = "opportunities"
    static let resourcesCollection = "resources"
    
    //user collections
    static let userSavedOpportunitiesCollection = "userSavedOpportunities"
    static let userSavedResourcesCollection = "userSavedResources"
    static let followedUsersCollection = "followedUsers"
    static let userPortfolioCollection = "userPortfolio"
    static let likedPostsCollection = "likedPosts"
    
    internal let db = Firestore.firestore()
}


