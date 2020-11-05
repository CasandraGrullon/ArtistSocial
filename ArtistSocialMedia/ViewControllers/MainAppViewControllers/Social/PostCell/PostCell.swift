//
//  PostCell.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 10/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    override func layoutSubviews() {
        self.backgroundColor = .systemBackground
        self.userProfileImage.layer.cornerRadius = userProfileImage.bounds.width / 2
    }
    
    public func configureCell(post: Post) {
        userNameLabel.text = post.userName
        
        if post.userProfilePicture != "" {
            userProfileImage.kf.setImage(with: URL(string: post.userProfilePicture))
        } else {
            userProfileImage.backgroundColor = .systemPink
        }
        
        if post.postText != "" {
            postTextLabel.text = post.postText
        }
        
        if post.postImage != "" {
            postImage.isHidden = false
            print(post.postImage)
            guard let url = URL(string: post.postImage) else {
                return
            }
            postImage.kf.setImage(with: url)
        } else {
            postImage.isHidden = true
        }
        
    }
    
}
