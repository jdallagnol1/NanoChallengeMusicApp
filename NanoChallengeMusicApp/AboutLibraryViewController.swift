//
//  AboutLibraryViewController.swift
//  NanoChallengeMusicApp
//
//  Created by João Vitor Dall Agnol Fernandes on 22/06/21.
//

import UIKit

class AboutLibraryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var libraryImageVIew: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackAmountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionTableView: UITableView!
    
    var collection: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryImageVIew.image = UIImage(named: collection?.id ?? "")
        
        albumLabel.text = collection?.title
        artistLabel.text = collection?.mainPerson
       
        let type = collection?.type.rawValue.capitalizingFirstLetter() ?? ""
        let artist = collection?.mainPerson ?? ""
        artistLabel.text = "\(type) by \(artist)"
        let time = collection?.musics.count ?? 0
        trackAmountLabel.text = "\(time) songs, [tempo do album]"
        //ainda falta formatar a data
        let date = collection?.referenceDate.description ?? ""
        releaseDateLabel.text = "Released in \(date)"
        
        descriptionTableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "about-library-cell") as! LibraryDescriptionTableViewCell
            cell.libraryDescriptionLabel.text = collection?.albumDescription
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "about-artist-cell") as! ArtistDescriptionTableViewCell
            let artist = collection?.mainPerson ?? ""
            cell.aboutArtistLabel.text = "About \(artist)"
            cell.artistDescriptionLabel.text = collection?.albumArtistDescription
            return cell
        }
    }
    
    @IBAction func closeBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}