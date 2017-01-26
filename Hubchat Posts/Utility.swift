//
//  Utility.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 26/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import DATAStack
import Sync

let APIBasePath         = "https://api.hubchat.com/v1"

class Utility: NSObject {
    let dataStack: DATAStack = DATAStack(modelName: "Hubchat Posts")
    
    // MARK: Network methods
    func fetchForum(slug: String, completion: @escaping (_ forum: Forum?, _ error: Error?) -> Void) {
        let path = "\(APIBasePath)/forum/\(slug)"
        
        Alamofire.request(path).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    if let forum = data["forum"] as? [String: Any] {
                        self.saveData(json: [forum], toEntity: "Forum", predicate: nil, completion: {
                            let predicate = NSPredicate(format: "slug = %@", slug)
                            
                            if let forums = self.fetchData(fromEntity: "Forum", predicate: predicate, sorters: nil) {
                                if let forum = forums.first as? Forum {
                                    completion(forum, nil)
                                } else {
                                    completion(nil, nil)
                                }
                            } else {
                                completion(nil, nil)
                            }
                        })
                    } else {
                        completion(nil, response.error)
                    }
                } else {
                    completion(nil, response.error)
                }
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
    func fetchPosts(fromForum slug: String, forumUUID uuid: String, completion: @escaping (_ posts: [Post]?, _ error: Error?) -> Void) {
        let path = "\(APIBasePath)/forum/\(slug)/post"
        
        Alamofire.request(path).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    if let posts = data["posts"] as? [[String: Any]] {
                        self.saveData(json: posts, toEntity: "Post", predicate: nil, completion: {
                            let predicate = NSPredicate(format: "forumUUID = %@", uuid)
                            
                            if let postArray = self.fetchData(fromEntity: "Post", predicate: predicate, sorters: nil) as? [Post] {
                                completion(postArray, nil)
                            } else {
                                completion(nil, nil)
                            }
                        })
                    } else {
                        completion(nil, response.error)
                    }
                } else {
                    completion(nil, response.error)
                }
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
    func downloadImage(_ path: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        Alamofire.request(path).responseData { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    completion(image, nil)
                } else {
                    completion(nil, response.error)
                }
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
    func callAPI(_ path: String, completion: @escaping (_ result: Any?, _ error: Error?) -> Void) {
        Alamofire.request(path).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    completion(data, nil)
                } else {
                    completion(nil, response.error)
                }
            case .failure:
                completion(nil, response.error)
            }
        }
    }
    
    // MARK: Database methods
    func saveData(json: [[String: Any]], toEntity name: String, predicate: NSPredicate?, completion: (() -> Void)?) {
        let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
        
        dataStack.performInNewBackgroundContext { backgroundContext in
            
            NotificationCenter.default.addObserver(self, selector: #selector(Utility.changeNotification(_:)), name: notifName, object: backgroundContext)
            
            Sync.changes(json,
                         inEntityNamed: name,
                         predicate: predicate,
                         parent: nil,
                         parentRelationship: nil,
                         inContext: backgroundContext,
                         operations: .All,
                         completion:  { error in
                            NotificationCenter.default.removeObserver(self, name: notifName, object: nil)
                            completion?()
            })
        }
    }
    
    func fetchData(fromEntity name: String, predicate: NSPredicate?, sorters: [NSSortDescriptor]?) -> [Any]? {
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
        request.predicate = predicate
        request.sortDescriptors = sorters
        var data:[Any]?
        
        do {
            data = try dataStack.mainContext.fetch(request)
            
        } catch {
            print("error: \(error)")
        }
        
        return data
    }
    
    // MARK: Utility methods
    func changeNotification(_ notification: NSNotification) {
        if let objects = notification.userInfo?[NSUpdatedObjectsKey] {
            print("updated: \((objects as AnyObject).count)")
        }
        
        if let objects = notification.userInfo?[NSDeletedObjectsKey] {
            print("deleted: \((objects as AnyObject).count)")
        }
        
        if let objects = notification.userInfo?[NSInsertedObjectsKey] {
            print("inserted: \((objects as AnyObject).count)")
        }
    }
    
    // MARK: - Shared Instance
    static let sharedInstance = Utility()
}
