//
//  DonationStatsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/28/21.
//

import UIKit

class DonationStatsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var player: UILabel!
    
    
    @IBOutlet weak var totalDonation: UILabel!
    
    
    @IBOutlet weak var attempts: UILabel!
    
    
    @IBOutlet weak var makes: UILabel!
    
    
    @IBOutlet weak var perShot: UILabel!
    
    
    @IBOutlet weak var flat: UILabel!
    
    
    func configure(with playerLabel: String, totalDon: Double, shotAttempts: Int, sMakes: Int, perShotDon: Double, flatDon: Double) {
        
        player.text = playerLabel
        totalDonation.text = String(totalDon)
        attempts.text = String(shotAttempts)
        makes.text = String(sMakes)
        perShot.text = String(perShotDon)
        flat.text = String(flatDon)
        
    } // func configure
    
    
    
}  // DonationStatsCollectionViewCell
