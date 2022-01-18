//
//  DonationStatsReusableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/10/22.
//

import UIKit

class DonationStatsReusableView: UICollectionReusableView {
        
    
    @IBOutlet weak var eventN: UILabel!
    
    @IBOutlet weak var eventD: UILabel!
    
    func configure(with eventName: String, eventDate: String) {
        
        eventN.text = eventName
        eventD.text = eventDate
        
    } // configure
    
    
}  // DonationStatsReuseableView
