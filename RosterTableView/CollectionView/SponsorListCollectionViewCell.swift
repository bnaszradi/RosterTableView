//
//  SponsorListCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/27/21.
//

import UIKit

class SponsorListCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var sponsorName: UILabel!
    
    
    @IBOutlet weak var amountPerShot: UILabel!
    
    
    @IBOutlet weak var donation: UILabel!
    
    
    func configure(with sponsorN: String, amountPerS: Double, donate: Double) {
        
        sponsorName.text = sponsorN
        
        amountPerShot.text = String(amountPerS)
        
        donation.text = String(donate)
        
        
        
    }  //configure func
    
    
    
    
} // SponsorListCollectionViewCell
