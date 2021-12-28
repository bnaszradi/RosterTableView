//
//  PlayerEventsCollectionReusableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/26/21.
//

import UIKit
import CloudKit

class PlayerEventsCollectionReusableView: UICollectionReusableView {
     
    
    @IBOutlet weak var playerName: UILabel!
    
    
    func configure(with playerN: String) {
        
        playerName.text = playerN
        
    } // configure
    
} // PlayerEventsCollectionReusableView
