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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
