//
//  ForumViewController.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 25/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import MBProgressHUD
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
        
        tableView!.register(HeaderImageTableViewCell.self, forCellReuseIdentifier: "HeaderImageCell")
        tableView!.register(ForumHeaderTableViewCell.self, forCellReuseIdentifier: "ForumHeaderCell")
        tableView!.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView!)
        
        // snap it!
        tableView!.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func fetchData() {
        let slug = "photography"
        
        MBProgressHUD.showAdded(to: tableView!, animated: true)
        Utility.sharedInstance.fetchForum(slug: slug, completion: { (forum: Forum?, error: Error?) in
            if let forum = forum {
                Utility.sharedInstance.fetchPosts(fromForum: slug, forumUUID: forum.uuid!, completion: { (posts: [Post]?, error: Error?) in
                    MBProgressHUD.hide(for: self.tableView!, animated: true)
                    if let posts = posts {
                        self.forumViewModel = ForumViewModel(withForum: forum, andPosts: posts)
                        self.navigationItem.title = forum.title
                        self.tableView!.reloadData()
                    }
                })
            }
        })
    }
    
    func makeHeaderImageTableViewCell() -> UITableViewCell {
        var cell:HeaderImageTableViewCell?
        
        if let c = tableView!.dequeueReusableCell(withIdentifier: "HeaderImageCell") as? HeaderImageTableViewCell {
            cell = c
        } else {
            cell = HeaderImageTableViewCell(style: .default, reuseIdentifier: "HeaderImageCell")
        }
        
        if let forumViewModel = forumViewModel,
            let cell = cell {
            
            forumViewModel.downloadForumHeaderImage(completion: { (image: UIImage?) in
                cell.headerImage!.image = image
            })
        }
        
        return cell!
    }
    
    func makeHeaderTableViewCell() -> UITableViewCell {
        var cell:ForumHeaderTableViewCell?
        
        if let c = tableView!.dequeueReusableCell(withIdentifier: "ForumHeaderCell") as? ForumHeaderTableViewCell {
            cell = c
        } else {
            cell = ForumHeaderTableViewCell(style: .subtitle, reuseIdentifier: "ForumHeaderCell")
        }
        
        if let forumViewModel = forumViewModel,
            let cell = cell {
            
            forumViewModel.downloadForumImage(completion: { (image: UIImage?) in
                cell.imageView?.image = image
            })
            cell.textLabel?.text = forumViewModel.forum.title
            cell.detailTextLabel?.text = forumViewModel.forum.description_
        }
        
        return cell!
    }

    func makePostTableViewCell(forIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell:PostTableViewCell?
        
        if let c = tableView!.dequeueReusableCell(withIdentifier: "PostCell") as? PostTableViewCell {
            cell = c
        } else {
            cell = PostTableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
        }
        
        if let forumViewModel = forumViewModel,
            let cell = cell {
            
            let post = forumViewModel.posts[indexPath.row]
            /*forumViewModel.downloadForumImage(completion: { (image: UIImage?) in
                cell.imageView?.image = image
            })*/
            cell.textLabel?.text = post.rawContent
            //cell.detailTextLabel?.text = forumViewModel.forum.description_
        }
        
        return cell!
    }

}

// MARK: UITableViewDataSource
extension ForumViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        switch section {
        case 0:
            rows = 2
        case 1:
            if let forumViewModel = forumViewModel {
                rows = forumViewModel.posts.count
            }
        default:
            ()
        }
        
        return rows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell:UITableViewCell?
        
        // make sure we fetched the form already
        if let _ = forumViewModel {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell = makeHeaderImageTableViewCell()
                case 1:
                    cell = makeHeaderTableViewCell()
                default:
                    cell = UITableViewCell()
                }
            case 1:
                cell = makePostTableViewCell(forIndexPath: indexPath)
            default:
                cell = UITableViewCell()
            }
        } else {
            cell = UITableViewCell()
        }
        
        return cell!
    }
}

// MARK: UITableViewDelegate
extension ForumViewController : UITableViewDelegate {
    
}
