//
//  TweetTableViewCell.swift
//  SwifferApp
//
//  Created by TurnToTech on 29/06/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet var usernameLabel: UILabel! = UILabel()
    @IBOutlet var timestampLabel: UILabel! = UILabel()
    @IBOutlet var tweetTextView: UITextView! = UITextView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
