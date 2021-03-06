//
//  SponsorReusableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/22/21.
//

import UIKit

class SponsorReusableView: UICollectionReusableView {
     
    
    @IBOutlet weak var eventN: UILabel!
    
    @IBOutlet weak var eventD: UILabel!
    
    func configure(with eventName: String, eventDate: String) {
        
        eventN.text = eventName
        eventD.text = eventDate
        
    } // configure
    
    
}  // SponsorReusableView
