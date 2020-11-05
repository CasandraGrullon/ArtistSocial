//
//  PostCell.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    //user details
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    //post content
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    //buttons
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    public static let reuseIdentifier = "postCell"
    //TODO: configure cell populated with Post object details
    public func configureCell(post: Post) {
        
    }
    
}
