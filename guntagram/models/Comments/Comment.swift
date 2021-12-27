//
//  Comment.swift
//  guntagram
//
//  Created by Cem Kılınç on 28.12.2021.
//

import Foundation
import Firebase

class Comment {
    let owner: DocumentReference
    let ownerUsername: String
    let comment: String
    
    init(owner: DocumentReference, ownerUsername: String, comment: String) {
        self.owner = owner
        self.ownerUsername = ownerUsername
        self.comment = comment
    }
}
