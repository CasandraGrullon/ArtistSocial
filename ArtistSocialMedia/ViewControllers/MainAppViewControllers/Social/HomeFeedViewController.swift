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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    private var searchController = UISearchController(searchResultsController: nil)
    
    private var followedUsers = [User]()
    private var posts = [Post]() {
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
    private var searchOn = false
    private var searchText = String() {
        didSet {
            //fetch users
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        fetchFollowedUsers()
    }
    //MARK:- Configure properties
    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "search for users"
        searchController.searchBar.autocapitalizationType = .none
    }
    private func configureCollectionView() {
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //        if let flowLayout = flowLayout,
        //           let collectionView = collectionView {
        //            print("flowlayout")
        //            let width = collectionView.frame.width
        //            let height = collectionView.frame.height * 0.2
        //            flowLayout.estimatedItemSize = CGSize(width: width, height: height)
        //        }
    }
    //MARK:- Network calls
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
                    self?.posts = posts//.filter {$0.datePosted == Date()}
                }
            }
        }
    }
    //MARK:- Button Actions
    @IBAction func searchNavButtonPressed(_ sender: UIBarButtonItem) {
        searchOn.toggle()        
    }
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        //go to add post view
        
    }
}
//MARK:- CollectionView extensions
extension HomeFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = collectionView.frame.width
        let maxHeight = collectionView.frame.height
        let adjustedWidth = CGFloat(maxWidth * 0.95)
        let adjustedHeight = CGFloat(maxHeight * 0.3)
        return CGSize(width: adjustedWidth, height: adjustedHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
        //TODO:- cell delegate (unfollow user/ edit own post)
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        return cell
    }
}
//MARK:- Search Controller Delegate Extensions
extension HomeFeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        searchText = text
    }
}
extension HomeFeedViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }
}
