//
//  EventsCollectionViewCell.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/13/21.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    
    
    @IBOutlet weak var eventDate: UILabel!
    
    
    func configure(with eventN: String, eventD: Date) {
        
        
        eventName.text = eventN
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        eventDate.text = dateFormatter.string(from: eventD)
        
        
    }  //configure func
    
   
    
}  // EventsCollectionViewCell
