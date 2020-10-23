//
//  PostDatabaseSession.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension DatabaseService {
    //fetch all posts - home feed - followed users posts
    public func fetchPosts(followedUser: User, completion: @escaping (Result<[Post], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.followedUsersCollection).document(followedUser.id).collection(DatabaseService.postsCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map {Post ($0.data())}
                completion(.success(posts))
            }
        }
    }
    //create a post
    public func createPost(postText: String? = nil, postImage: String? = nil, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.postsCollection).addDocument(data: ["postText": postText ?? "", "postImage": postImage ?? ""]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //edit a post
    public func editPost(post: Post, postText: String, completion: @escaping (Result<Bool, Error>) -> ()){
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.postsCollection).document(post.id).updateData(["postText": postText]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    //delete a post
    public func deletePost(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.postsCollection).document(post.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
