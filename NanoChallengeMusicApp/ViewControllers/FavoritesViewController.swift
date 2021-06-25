//
//  FavoritesViewController.swift
//  NanoChallengeMusicApp
//
//  Created by João Vitor Dall Agnol Fernandes on 24/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var service: MusicService = MusicService.instance
    var favoriteSongs: [Music]?
 
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteSongs = service.favoriteMusics
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteSongs?.count == 0 {
            return 1
        }
        return favoriteSongs?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: MusicTableViewCell
        
        if favoriteSongs?.isEmpty ?? true {
            cell = tableView.dequeueReusableCell(withIdentifier: "empty-favorite-cell", for: indexPath) as! MusicTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "favorite-music-cell", for: indexPath) as! MusicTableViewCell
            let music = favoriteSongs?[indexPath.row]
            
            cell.music = music
            cell.service = service
            cell.titleLabel?.text = music?.title
            cell.subtitleLabel?.text = music?.artist
            cell.musicImageView?.image = service.getCoverImage(forItemIded: music?.id ?? "")
            
            if service.favoriteMusics.contains(music!) {
                cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.favStatusButtonOutlet.tintColor = .red
            } else {
                cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.favStatusButtonOutlet.tintColor = .black
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(favoriteSongs?.isEmpty ?? true) {
            service.startPlaying(music: favoriteSongs![indexPath.row])
            performSegue(withIdentifier: "fromFavoriteToPaying", sender: favoriteSongs![indexPath.row])
        }
    }
    
}
