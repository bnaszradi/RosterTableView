//
//  QSponsorWithShots.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/5/21.
//

import Foundation
import CloudKit

struct QSponsorWithShots {
    
    var sponsorID: CKRecord.ID = CKRecord.ID()
    
    var totAttempt: Int
    var totMake: Int
    var totPerShot: Double
    var totFlatDon: Double
    var totalDonation: Double
    
    
    /*
    var totAttempt = [] as Array<Int>
    var totMake = [] as Array<Int>
    var totPerShot = [] as Array<Double>
    var totFlatDon = [] as Array<Double>
    var totalDonation = [] as Array<Double>
    */

}  // QSponsorWithShots
