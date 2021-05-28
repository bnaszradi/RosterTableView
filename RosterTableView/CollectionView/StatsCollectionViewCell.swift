//
//  StatsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/30/21.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var player: UILabel!
    
    @IBOutlet weak var dateCreated: UILabel!
    
    @IBOutlet weak var attempts: UILabel!
    
    @IBOutlet weak var percentage: UILabel!
    
    @IBOutlet weak var makes: UILabel!
    
   // var teamReferen: CKRecord.ID = CKRecord.ID()
    
    
    func configure(with playerLabel: String, date: Date, shotAttempts: Int, sMakes: Int, percent: Int) {
        
        player.text = playerLabel
      //  shotType.text = shot
        attempts.text = String(shotAttempts)
        makes.text = String(sMakes)
        percentage.text = String(percent)
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        dateCreated.text = dateFormatter.string(from: date)
        
       // teamRef.text = String(teamReferen)
        
    }  //configure func
   
    
    
    
}  // StatsCollectionViewCell
