//
//  PodcastTableViewCell.swift
//  Podcasts
//
//  Created by Angel Torres on 21/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePodcast: UIImageView!
    @IBOutlet weak var titlePodcast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
