//
//  SponsorReusableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/22/21.
//

import UIKit

class SponsorReusableView: UICollectionReusableView {
     
    
    @IBOutlet weak var eventN: UILabel!
    

    func configure(with eventName: String) {
        
        eventN.text = eventName
        
    } // configure
    
    
}  // SponsorReusableView
