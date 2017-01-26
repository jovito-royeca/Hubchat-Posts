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
    
    // MARK: Custom methods
    func downloadForumHeaderImage(completion: @escaping (_ image: UIImage?) -> Void) {
        if let path = getForumHeaderImagePath() {
            Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                if let error = error {
                    print("\(error)")
                }
                completion(image)
            })
        }
    }
    
    func downloadForumImage(completion: @escaping (_ image: UIImage?) -> Void) {
        if let path = getForumImagePath() {
            Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                if let error = error {
                    print("\(error)")
                }
                completion(image)
            })
        }
    }
    
    func downloadCreatorAvatar(forPost post: Post, completion: @escaping (_ image: UIImage?) -> Void) {
        if let path = getCreatorAvatarPath(forPost: post) {
            Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                if let error = error {
                    print("\(error)")
                }
                completion(image)
                
            })
        }
    }
    
    func downloadImages(forPost post: Post, completion: @escaping (_ image: UIImage?) -> Void) {
        if let paths = getImagesPath(forPost: post) {
            // download only the first image??
            if let path = paths.first {
                Utility.sharedInstance.downloadImage(path, completion: { (image: UIImage?, error: Error?) in
                    if let error = error {
                        print("\(error)")
                    }
                    completion(image)
                    
                })
            }
        }
    }
    
    func getForumHeaderImagePath() -> String? {
        if let headerImage = forum.headerImage {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: headerImage as Data) as? Dictionary<String,AnyObject> {
                return cfVal["url"] as? String
            }
        }
            
        return nil
    }
        
    func getForumImagePath() -> String? {
        if let image = forum.image {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: image as Data) as? Dictionary<String,AnyObject> {
                return cfVal["url"] as? String
            }
        }
        
        return nil
    }
    
    func getCreatorAvatarPath(forPost post: Post) -> String? {
        let p = posts[posts.index(of: post)!]
        
        if let createdBy = p.createdBy {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: createdBy as Data) as? Dictionary<String,AnyObject> {
                if let avatar = cfVal["avatar"] as? [String: Any] {
                    return avatar["url"] as? String
                }
            }
        }
        
        return nil
    }
    
    func getImagesPath(forPost post: Post) -> [String]? {
        let p = posts[posts.index(of: post)!]
        
        if let entities = p.entities {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: entities as Data) as? Dictionary<String,AnyObject> {
                if let images = cfVal["images"] as? [[String: Any]] {
                    var paths = [String]()
                    
                    for image in images {
                        for (key,value) in image {
                            if key == "cdnUrl" {
                                paths.append((value as? String)!)
                            }
                        }
                    }
                    return paths
                }
            }
        }
        
        return nil
    }
    
    func getCreatorDisplayName(forPost post: Post) -> String? {
        let p = posts[posts.index(of: post)!]
        
        if let createdBy = p.createdBy {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: createdBy as Data) as? Dictionary<String,AnyObject> {
                return cfVal["displayName"] as? String
            }
        }
        
        return nil
    }
    
    func getUpVotes(forPost post: Post) -> String? {
        let p = posts[posts.index(of: post)!]
        
        if let stats = p.stats {
            if let cfVal = NSKeyedUnarchiver.unarchiveObject(with: stats as Data) as? Dictionary<String,AnyObject> {
                return "Up Votes: \(cfVal["upVotes"]!)"
            }
        }
        
        return nil
    }
}
