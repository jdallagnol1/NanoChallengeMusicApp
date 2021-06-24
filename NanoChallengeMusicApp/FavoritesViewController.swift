//
//  FavoritesViewController.swift
//  NanoChallengeMusicApp
//
//  Created by João Vitor Dall Agnol Fernandes on 24/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
  
    var service: MusicService?
    var favoriteSongs: [Music]?
 
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.service = try MusicService()
        } catch {
            print(error)
        }
        
        favoriteSongs = service?.favoriteMusics
        
        favoritesTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteSongs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = favoriteSongs?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite-music-cell", for: indexPath) as! MusicTableViewCell
        cell.music = music
        cell.service = service
        
        cell.titleLabel?.text = music?.title
        cell.subtitleLabel?.text = music?.artist
        cell.musicImageView?.image = UIImage(named: "\(music?.id ?? "")")
        
        if service?.favoriteMusics.contains(music!) ?? false {
            cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favStatusButtonOutlet.tintColor = .red
        } else {
            cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.favStatusButtonOutlet.tintColor = .black
        }
        
        return cell
    }
    
}
