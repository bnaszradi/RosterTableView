//
//  SponsorStatsReusableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/23/21.
//

import UIKit

class SponsorStatsReusableView: UICollectionReusableView {
        
    
    @IBOutlet weak var eventN: UILabel!
    
    func configure(with eventName: String) {
        
        eventN.text = eventName
        
    } // configure
    
}  // SponsorReusableView
    
    
