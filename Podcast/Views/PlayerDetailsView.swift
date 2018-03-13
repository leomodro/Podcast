//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Leonardo Modro on 13/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            guard let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
}