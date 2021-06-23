//
//  AlbumPlaylistDetailsViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 21/06/21.
//

import UIKit

class AlbumPlaylistDetailsViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var libraryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainPersonLabol: UILabel!
    @IBOutlet weak var numberOfSongs: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var songsLibraryTableView: UITableView!
   
    
    var musicColection: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryImageView.image = UIImage(named: "\(musicColection?.id ?? "")")
        titleLabel.text = musicColection?.title
        mainPersonLabol.text = musicColection?.mainPerson
        
        let numSongs = musicColection?.musics.count ?? 0
        numberOfSongs.text =  "\(numSongs) songs"
        
        dateLabel.text = musicColection?.referenceDate.description
        
        navigationItem.title = musicColection?.title
        
        songsLibraryTableView.dataSource = self
        
        if musicColection?.type == .playlist {
            navigationItem.rightBarButtonItem = nil
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicColection?.musics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "music-cell", for: indexPath) as! MusicTableViewCell
        
        cell.titleLabel?.text = musicColection?.musics[indexPath.row].title
        cell.subtitleLabel?.text = musicColection?.musics[indexPath.row].artist
        cell.musicImageView?.image = UIImage(named: "\(musicColection?.musics[indexPath.row].id ?? "")")
        
        return cell
    }
    
    @IBAction func presentDetailsAction(_ sender: Any) {
        performSegue(withIdentifier: "goToDetails", sender: musicColection)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let aboutView = segue.destination as? AboutLibraryViewController
        else { return }
        
        guard let value = sender as? MusicCollection else { return }
        
        aboutView.collection = value
//
    }
}
