//
//  SponssorStatsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/29/21.
//

import UIKit


class SponssorStatsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sponsorName: UILabel!
    
    @IBOutlet weak var totalDonation: UILabel!
    
    @IBOutlet weak var makes: UILabel!
    
    @IBOutlet weak var perShot: UILabel!
    
    @IBOutlet weak var flat: UILabel!
    
    func configure(with sponsorN: String, totalDon: Double, sMakes: Int, perShotDon: Double, flatDon: Double) {
        
        sponsorName.text = sponsorN
        totalDonation.text = String(totalDon)
        makes.text = String(sMakes)
        perShot.text = String(perShotDon)
        flat.text = String(flatDon)
        
    } // func configure
    
    
} // SponsorStatsCollectionViewCell
