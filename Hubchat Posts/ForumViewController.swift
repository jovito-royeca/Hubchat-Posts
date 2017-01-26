//
//  ForumViewController.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 25/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import SnapKit

class ForumViewController: UIViewController {

    // MARK: Variables
    var forumViewModel:ForumViewModel?
    var tableView:UITableView?

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        fetchData()
    }
    
    // MARK: Custom methods
    func setupUI() {
        tableView = UITableView(frame: view.frame)
        tableView!.dataSource = self
        tableView!.delegate = self
        view.addSubview(tableView!)
    }
    
    func fetchData() {
        let slug = "photography"
        
        Utility.sharedInstance.fetchForum(slug: slug, completion: { (forum: Forum?, error: Error?) in
            if let forum = forum {
                Utility.sharedInstance.fetchPosts(fromForum: slug, forumUUID: forum.uuid!, completion: { (posts: [Post]?, error: Error?) in
                    if let posts = posts {
                        self.forumViewModel = ForumViewModel(withForum: forum, andPosts: posts)
                        self.tableView!.reloadData()
                    }
                })
            }
        })
    }
}

// MARK: UITableViewDataSource
extension ForumViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension ForumViewController : UITableViewDelegate {
    
}
