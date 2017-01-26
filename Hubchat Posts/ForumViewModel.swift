//
//  ForumViewModel.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 25/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit

class ForumViewModel: NSObject {
    let forum: Forum
    let posts: [Post]
    
    // MARK: Initialization
    init(withForum forum: Forum, andPosts posts: [Post]) {
        self.forum = forum
        self.posts = posts
    }
}
