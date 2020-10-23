//
//  OpportunityDatabaseSession.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension DatabaseService {
    //fetch opportunities
    public func fetchOpportunities(completion: @escaping (Result<[Opportunity], Error>) -> ()) {
        db.collection(DatabaseService.opportunitiesCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let opportunities = snapshot.documents.map {Opportunity ($0.data())}
                completion(.success(opportunities))
            }
        }
    }
    //create opportunity -> poster
    public func createOpportunity(type: String, title: String, detail: String, location: String, email: String, phoneNumber: String? = nil, link: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.opportunitiesCollection).addDocument(data: ["type": type, "title": title, "detail": detail, "location": location, "email": email, "phoneNumber": phoneNumber ?? "", "link": link, "userID": user.uid]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //delete opportunity -> poster
    public func deleteOpportunity(opportunity: Opportunity, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.opportunitiesCollection).document(opportunity.id).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //edit opportunity -> poster
    public func deleteOpportunity(opportunity: Opportunity, type: String, title: String, detail: String, location: String, email: String, phoneNumber: String? = nil, link: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.opportunitiesCollection).document(opportunity.id).updateData(["type": type, "title": title, "detail": detail, "location": location, "email": email, "phoneNumber": phoneNumber ?? "", "link": link]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    //add opportunity to collection -> user
    
    //remove opportunity from collection -> user
    
    //check if opportunity is in collection -> user
}
