//
//  PortfolioDatabaseSession.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/22/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension DatabaseService {
    //fetch user profile/portfolio
    public func fetchUserPortfolio(userId: String, completion: @escaping (Result<[Portfolio], Error>) -> ()) {
        db.collection(DatabaseService.userCollection).document(userId).collection(DatabaseService.userPortfolioCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let portfolio = snapshot.documents.map {Portfolio ($0.data())}
                completion(.success(portfolio))
            }
        }
    }
    //add to portfolio
    public func addToPortfolio(image: String, description: String, tags: [String], yearCompleted: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.userPortfolioCollection).addDocument(data: ["image": image, "description": description, "tags": tags, "yearCompleted": yearCompleted ]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //delete from porfolio
    public func deleteFromPortfolio(portfolioPiece: Portfolio, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.userPortfolioCollection).document(portfolioPiece.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //edit portfolio
    public func editPortfolioPiece(portfolioPiece: Portfolio, description: String, tags: [String], yearCompleted: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.userPortfolioCollection).document(portfolioPiece.id).updateData(["description": description, "tags": tags, "yearCompleted": yearCompleted]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
