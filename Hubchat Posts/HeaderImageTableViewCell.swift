//
//  HeaderImageTableViewCell.swift
//  Hubchat Posts
//
//  Created by Jovito Royeca on 26/01/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import SnapKit

class HeaderImageTableViewCell: UITableViewCell {

    var headerImage:UIImageView?

    // MARK: Overrides
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
        
        headerImage = UIImageView(frame: frame)
        headerImage?.contentMode = .scaleAspectFit
        addSubview(headerImage!)
        
        headerImage!.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
