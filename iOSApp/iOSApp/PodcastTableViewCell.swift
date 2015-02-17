//
//  PodcastTableViewCell.swift
//  iOSApp
//
//  Created by Mark Schall on 2/17/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodLabCommoniOS

class PodcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastTitleLabel: UILabel!
    @IBOutlet weak var podcastSubtitleLabel: UILabel!
    
    func setPodcast( podcast : Podcast ) {
        podcastTitleLabel.text = podcast.title
    }
    
    override func prepareForReuse() {
        podcastImageView.image = nil;
        podcastTitleLabel.text = ""
        podcastSubtitleLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
