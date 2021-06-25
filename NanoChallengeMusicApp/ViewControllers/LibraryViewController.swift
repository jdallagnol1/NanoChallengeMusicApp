//
//  LibraryViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 21/06/21.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    var service: MusicService = MusicService.instance
    var library: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.library = service.loadLibrary()
        
        libraryTableView.dataSource = self
        libraryTableView.delegate = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "library-cell", for: indexPath) as! LibrariesTableViewCell
        let cellLibrary = library[indexPath.row]
        
        cell.libraryImageView.image = service.getCoverImage(forItemIded: cellLibrary.id)
        cell.titleLabel.text = cellLibrary.title
        cell.subtitleLabel.text = "\(cellLibrary.type.rawValue.capitalizingFirstLetter()) · \(cellLibrary.mainPerson)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAlbumPlaylistDetails", sender: library[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let albumPlaylistDetailsViewController = segue.destination as? AlbumPlaylistDetailsViewController else { return }

        albumPlaylistDetailsViewController.musicColection = sender as? MusicCollection
    }
    
}
