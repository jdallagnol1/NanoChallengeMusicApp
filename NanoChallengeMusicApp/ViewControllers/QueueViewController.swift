//
//  QueueViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 24/06/21.
//

import UIKit

class QueueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var queueTableView: UITableView!
    
    var service: MusicService = MusicService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queueTableView.dataSource = self
        queueTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var qtd: Int = 0
        
        if section == 0 {
            qtd = 1
        } else if section == 1 {
            qtd = service.queue.nextInCollection.count
        } else if section == 2 {
            qtd = service.queue.nextSuggested.count
        }
            
        return qtd
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queue-cell", for: indexPath) as! MusicTableViewCell
        
        var music: Music = service.queue.nowPlaying!
        
        if indexPath.section == 1 {
            music = service.queue.nextInCollection[indexPath.row]
        } else if indexPath.section == 2 {
            music = service.queue.nextSuggested[indexPath.row]
        }

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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String = ""
        
        if section == 0 {
            title = "Now Playing"
        } else if section == 1 {
            title = "Next in Loud"
        } else if section == 2 && service.queue.nextSuggested.count > 0 {
            title = "Next: Suggested"
        }
        
        return title
    }
    
    // O QUE ACONTECE QUANDO CLICAMOS NUMA MUSICA NA QUEUE?
    // PQ NÃO TÁ PEGANDO O CLIQUE?
    // MODIFIQUEI O MÉTODO startPlaying NA CLASSE DO RARA PRA PLAYING SEGUIR O QUE ESTÁ NO service.queue.nowPlaying MANDANDO A MUSIC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var music: Music!
//        
//        if indexPath.section == 0 {
//            self.dismiss(animated: true)
//        } else if indexPath.section == 1 {
//            music = service.queue.nextInCollection[indexPath.row]
//        } else if indexPath.section == 2 {
//            music = service.queue.nextSuggested[indexPath.row]
//        }
//        
//        if service.queue.collection != nil {
//            service.startPlaying(collection: service.queue.collection!, music: music)
//        } else {
//            service.startPlaying(music: music)
//        }
//
//        self.dismiss(animated: true)
    }
    
    @IBAction func closeQueueButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
