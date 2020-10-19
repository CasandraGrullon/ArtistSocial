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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
    }
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        //collectionView.delegate = self
        //collectionView.dataSource = self
    }
    
    @IBAction func searchNavButtonPressed(_ sender: UIBarButtonItem) {
        //search controller appears or is hidden
    }
    
    @IBAction func addPostButtonPressed(_ sender: UIButton) {
        //go to add post view
    }
    
}

