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
    
    func downloadForumHeaderImage(completion: @escaping (_ image: UIImage?) -> Void) {
        if let path = getForumHeaderImage() {
            Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                if let error = error {
                    print("\(error)")
                } else {
                    completion(image)
                }
            })
        }
    }
    
    func downloadForumImage(completion: @escaping (_ image: UIImage?) -> Void) {
        if let path = getForumImage() {
            Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                if let error = error {
                    print("\(error)")
                } else {
                    completion(image)
                }
            })
        }
    }
    
    func getForumHeaderImage() -> String? {
        if let headerImage = forum.headerImage {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: headerImage as Data) as? Dictionary<String,AnyObject> {
                return cfVal["url"] as? String
            }
        }
            
        return nil
    }
        
    func getForumImage() -> String? {
        if let image = forum.image {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: image as Data) as? Dictionary<String,AnyObject> {
                return cfVal["url"] as? String
            }
        }
        
        return nil
    }
}
