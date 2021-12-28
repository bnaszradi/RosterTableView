//
//  PlayerEventsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/26/21.
//

import UIKit

class PlayerEventsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var event: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var attempts: UILabel!
    
    @IBOutlet weak var makes: UILabel!
    
    @IBOutlet weak var perShot: UILabel!
    
    @IBOutlet weak var flat: UILabel!
    
    
    func configure(with eventN: String, totalD: Double, totAttempts: Int, totMakes: Int, totPerShot: Double, totFlat: Double) {
        
    event.text = eventN
     
    total.text = String(totalD)
    attempts.text = String(totAttempts)
    makes.text = String(totMakes)
    perShot.text = String(totPerShot)
    flat.text = String(totFlat)
        
        
    } // configure
    
    
   /*
    func configure(with playerLabel: String, totalDon: Double, shotAttempts: Int, sMakes: Int, perShotDon: Double, flatDon: Double) {
        
        player.text = playerLabel
        totalDonation.text = String(totalDon)
        attempts.text = String(shotAttempts)
        makes.text = String(sMakes)
        perShot.text = String(perShotDon)
        flat.text = String(flatDon)
        
    } // func configure
    
    
   */
    
    
    
} // PlayerEvents
