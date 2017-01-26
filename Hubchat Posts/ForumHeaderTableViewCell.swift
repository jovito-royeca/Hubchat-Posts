//
//  ForumHeaderTableViewCell.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 26/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import SnapKit

let ForumHeaderViewCellHeight = CGFloat(90)

class ForumHeaderTableViewCell: UITableViewCell {
    var forumImage:UIImageView?
    var titleLabel:UILabel?
    var descriptionLabel:UILabel?
    
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
        width = 50
        height = 50
        forumImage = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        forumImage!.contentMode = .scaleToFill
        addSubview(forumImage!)
        
        x = 70
        y = 10
        width = self.frame.width-x-10
        height = 30
        titleLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        titleLabel!.textColor = UIColor.blue
        addSubview(titleLabel!)
        
        x = 70
        y += titleLabel!.frame.size.height
        width = self.frame.width-x-10
        height = 30
        descriptionLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        descriptionLabel!.numberOfLines = 0
        descriptionLabel!.adjustsFontSizeToFitWidth = true
        addSubview(descriptionLabel!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
