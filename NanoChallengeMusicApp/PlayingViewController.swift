//
//  PlayingViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 23/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var nameMusicLabel: UILabel!
    @IBOutlet weak var nameArtistLabel: UILabel!
    @IBOutlet weak var favoriteStatusButton: UIButton!
    
    var music: Music?
    var service: MusicService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        do {
            self.service = try MusicService()
        } catch {
            print(error)
        }
        
        musicImageView.image = service?.getCoverImage(forItemIded: music?.id ?? "")
        nameMusicLabel.text = music?.title
        nameArtistLabel.text = music?.artist
        
        if service?.favoriteMusics.contains(music!) ?? false {
            favoriteStatusButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteStatusButton.tintColor = .red
        } else {
            favoriteStatusButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteStatusButton.tintColor = .none

        }
        
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        service?.toggleFavorite(music: music!, isFavorite: service?.favoriteMusics.contains(music!) ?? false)
        
        if service?.favoriteMusics.contains(music!) ?? false {
            favoriteStatusButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteStatusButton.tintColor = .red
        } else {
            favoriteStatusButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteStatusButton.tintColor = .none
        }
    }

}
