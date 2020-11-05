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
            if self.posts.isEmpty {
                self.collectionView.backgroundView = EmptyView(title: "No Posts!", message: "Follow other users to see what they're posting")
            } else {
                self.collectionView.reloadData()
                self.collectionView.backgroundView = nil
            }
        }
    }
    private var posts = [Post]()
    private var searchOn = false {
        didSet {
            configureSearchController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchFollowedUsers()
    }
    private func configureSearchController() {
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
        collectionView.delegate = self
        collectionView.dataSource = self
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
                    for user in users {
                        self?.fetchPosts(for: user)
                    }
                }
            }
        }
    }
    //Fetch followed users' posts
    private func fetchPosts(for user: User) {
        DatabaseService.shared.fetchPosts(followedUser: user) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.posts = posts.filter {$0.datePosted == Date()}
                }
            }
        }
    }
}

//MARK:- CollectionView extensions
extension HomeFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = view.frame.width
        let maxHeight = view.frame.height
        let adjustedWidth = CGFloat(maxWidth * 0.3)
        let adjustedHeight = CGFloat(maxHeight / 6)
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
extension HomeFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            fatalError("Could not dequeue cell")
        }
        //TODO: based on the followed users, posts are populated
        return cell
    }
}
