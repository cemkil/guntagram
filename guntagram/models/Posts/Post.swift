//
//  Post.swift
//  guntagram
//
//  Created by Ali Sutcu on 16.12.2021.
//

import Foundation
import UIKit
import Firebase

class Post {
    let uiImage: UIImage
    var likeCount: Int = 0
    let owner: DocumentReference
    let postReference: DocumentReference
    var likingUsers: [DocumentReference]
    var isPostLiked: Bool
    
    init(uiImage : UIImage, likeCount: Int, owner: DocumentReference, postReference: DocumentReference, likingUsers: [DocumentReference], isPostLiked: Bool) {
        self.likingUsers = likingUsers
        self.postReference = postReference
        self.isPostLiked = isPostLiked
        self.likeCount = likeCount
        self.owner = owner
        self.uiImage = uiImage
    }
}
