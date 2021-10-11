//
//  EventPlayerStatsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/20/21.
//

import UIKit

class EventPlayerStatsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var player: UILabel!
    
    @IBOutlet weak var dateCreated: UILabel!
    
    @IBOutlet weak var attempts: UILabel!
    
    @IBOutlet weak var makes: UILabel!
    
    @IBOutlet weak var percentage: UILabel!
    
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
        
    }  //configure func
   
    
    
} // EventPlayerStatsCollectionViewCell
