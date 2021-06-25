//
//  AlbumPlaylistDetailsViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 21/06/21.
//

import UIKit

class AlbumPlaylistDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet weak var libraryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainPersonLabol: UILabel!
    @IBOutlet weak var numberOfSongs: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var songsLibraryTableView: UITableView!
   
    var service: MusicService = MusicService.instance
    var musicColection: MusicCollection!

    override func viewDidLoad() {
        super.viewDidLoad()

        libraryImageView.image = service.getCoverImage(forItemIded: musicColection.id )
        titleLabel.text = musicColection.title
        
        let type = musicColection.type
        mainPersonLabol.text = type.rawValue.capitalizingFirstLetter() + " by " + musicColection.mainPerson
        
        let numSongs = musicColection.musics.count
        numberOfSongs.text =  "\(numSongs) songs"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let date = dateFormatter.string(from: musicColection.referenceDate)

        if type == .album {
            dateLabel.text = "Released " + date
        } else if type == .playlist {
            dateLabel.text = "Created "  + date
        }
        
        navigationItem.title = musicColection.title
        
        songsLibraryTableView.dataSource = self
        songsLibraryTableView.delegate = self
        
        if musicColection.type == .playlist {
            navigationItem.rightBarButtonItem = nil
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicColection.musics.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let music = musicColection.musics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "music-cell", for: indexPath) as! MusicTableViewCell
        cell.music = music
        
        cell.titleLabel.text = music.title
        cell.subtitleLabel.text = music.artist
        cell.musicImageView.image = service.getCoverImage(forItemIded: music.id)
        
        if service.favoriteMusics.contains(music) {
            cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favStatusButtonOutlet.tintColor = .red
        } else {
            cell.favStatusButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.favStatusButtonOutlet.tintColor = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        service.startPlaying(collection: musicColection, music: musicColection.musics[indexPath.row])
        performSegue(withIdentifier: "fromAboutToPaying", sender: nil)
    }
    
    @IBAction func presentDetailsAction(_ sender: Any) {
        performSegue(withIdentifier: "goToDetails", sender: musicColection)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            guard let aboutView = segue.destination as? AboutLibraryViewController
            else { return }
            
            guard let value = sender as? MusicCollection else { return }
            
            aboutView.collection = value
        } else if segue.identifier == "fromAboutToPaying" {
            guard let playing = segue.destination as? PlayingViewController
            else { return }
                        
            playing.presentationController?.delegate = self
        }
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        songsLibraryTableView.reloadData()
    }
    
}
