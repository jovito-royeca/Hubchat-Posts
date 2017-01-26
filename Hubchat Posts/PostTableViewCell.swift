//
//  PostTableViewCell.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 26/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit

let PostTableViewCellHeight = CGFloat(200)

class PostTableViewCell: UITableViewCell {
    var avatarImage:UIImageView?
    var nameLabel:UILabel?
    var descriptionLabel:UILabel?
    var postImage:UIImageView?
    var upVotesLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        x = 10
        y = 10
        width = 30
        height = 30
        avatarImage = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        avatarImage!.contentMode = .scaleToFill
        avatarImage!.layer.cornerRadius = height / 2
        avatarImage!.layer.masksToBounds = true
        avatarImage!.layer.borderWidth = 0
        addSubview(avatarImage!)
        
        x = 50
        y = 10
        width = self.frame.width-x-10
        height = 30
        nameLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        nameLabel!.textColor = UIColor.blue
        addSubview(nameLabel!)
        
        x = 10
        y += nameLabel!.frame.size.height
        width = self.frame.width-x-10
        height = 30
        descriptionLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        descriptionLabel!.numberOfLines = 0
        descriptionLabel!.adjustsFontSizeToFitWidth = true
        addSubview(descriptionLabel!)
        
        x = 0
        y += descriptionLabel!.frame.size.height
        width = self.frame.width
        height = 100
        postImage = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        postImage!.contentMode = .scaleAspectFit
        addSubview(postImage!)
        
        x = 10
        y += postImage!.frame.size.height
        width = self.frame.width-x-10
        height = 30
        upVotesLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        upVotesLabel!.font = UIFont.systemFont(ofSize: 10)
        addSubview(upVotesLabel!)
        
        // snap them
        /*        avatarImage!.snp.makeConstraints { (make) -> Void in
         make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
         }
         nameLabel!.snp.makeConstraints { (make) -> Void in
         make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
         }
         descriptionLabel!.snp.makeConstraints { (make) -> Void in
         make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
         }
         postImage!.snp.makeConstraints { (make) -> Void in
         make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
         }
         upVotesLabel!.snp.makeConstraints { (make) -> Void in
         make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
         }*/
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
