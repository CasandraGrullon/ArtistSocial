//
//  ViewController.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addPostButton: UIButton!
    
    private var followedUsers = [User]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var searchOn = false {
        didSet {
            configureSearchBar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchFollowedUsers()
    }
    private func configureSearchBar() {
        if searchOn {
            navigationItem.searchController?.isActive = true
            navigationItem.searchController?.searchBar.isHidden = false
        } else {
            navigationItem.searchController?.isActive = false
            navigationItem.searchController?.searchBar.isHidden = true
        }
    }
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        //collectionView.delegate = self
        //collectionView.dataSource = self
    }
    
    @IBAction func searchNavButtonPressed(_ sender: UIBarButtonItem) {
        //search controller appears or is hidden
        searchOn = searchOn == false ? true : false
        //accountState = accountState == .existingUser ? .newUser : .existingUser
    }
    
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        //go to add post view
    }
    //Fetch followed users
    private func fetchFollowedUsers() {
        DatabaseService.shared.fetchFollowedUsers { [weak self] (result) in
            switch result {
            case .failure(let error):
                //TODO: add show alert
                print(error)
            case .success(let users):
                DispatchQueue.main.async {
                    self?.followedUsers = users
                }
            }
        }
    }
}

