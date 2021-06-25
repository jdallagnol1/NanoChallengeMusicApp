//
//  MusicTableViewCell.swift
//  NanoChallengeMusicApp
//
//  Created by João Vitor Dall Agnol Fernandes on 22/06/21.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var favStatusButtonOutlet: UIButton!
    
    var service: MusicService = MusicService.instance
    var music: Music?
    
    @IBAction func favButtonAction(_ sender: UIButton) {
        
        service.toggleFavorite(music: music!, isFavorite: !service.favoriteMusics.contains(music!))
        
        if service.favoriteMusics.contains(music!) {
            favStatusButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favStatusButtonOutlet.tintColor = .red
        } else {
            favStatusButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            favStatusButtonOutlet.tintColor = .none
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
