//
//  storyCell.swift
//  Instagram
//
//  Created by Bijesh Subedi on 2/26/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class storyCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var storyImageView: PFImageView!
    
    var post: Post! {
        didSet{
            print(post)
            self.captionLabel.text = post.caption
            self.storyImageView.file = post.media
            self.storyImageView.loadInBackground()
            self.usernameLabel.text = PFUser.current()?.username
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
