//
//  UserDatabaseSession.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

extension DatabaseService {
    //create database user
    public func createAppUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>)-> ()) {
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.userCollection).document(authDataResult.user.uid).setData(["email": email, "id": authDataResult.user.uid]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //delete database user
    public func deleteDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>)-> ()) {
        db.collection(DatabaseService.userCollection).document(authDataResult.user.uid).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //fetch all app
    public func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        db.collection(DatabaseService.userCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let users = snapshot.documents.map {User ($0.data())}
                completion(.success(users))
            }
        }
    }
    //fetch users the current user is following
    public func fetchFollowedUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.followedUsersCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let users = snapshot.documents.map {User ($0.data())}
                completion(.success(users))
            }
        }
    }
    //unfollow user
    public func unfollowUser(followedUser: User, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.followedUsersCollection).document(followedUser.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //follow user
    public func followUser(followedUser: User, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.followedUsersCollection).addDocument(data: ["id": followedUser.id, "name": followedUser.name, "email": followedUser.email, "username": followedUser.username, "location": followedUser.location, "profession": followedUser.profession]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
