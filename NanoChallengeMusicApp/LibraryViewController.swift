//
//  LibraryViewController.swift
//  NanoChallengeMusicApp
//
//  Created by Igor Marques Vicente on 21/06/21.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    var service: MusicService?
    var library: [MusicCollection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.service = try MusicService()
            self.library = service?.loadLibrary()
        } catch {
            print(error)
        }
        
        libraryTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "library-cell", for: indexPath)
        
        let typeLibrary = library?[indexPath.row].type.rawValue ?? ""
        let authorLibrary = library?[indexPath.row].mainPerson ?? ""
        
        cell.textLabel?.text = library?[indexPath.row].title
        cell.detailTextLabel?.text = "\(typeLibrary) · \(authorLibrary)"
        
        return cell
    }

}
