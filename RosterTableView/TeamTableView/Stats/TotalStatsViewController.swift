//
//  TotalStatsViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 10/16/21.
//

import UIKit
import CloudKit

class TotalStatsViewController: UIViewController {

    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    let totalStats = TotalStats()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let eventResults = totalStats.queryEventTotals(tName: team, eName: eventName, eDate: eDate)
        
        // Get value for donationTotal
        let donationTotal: Array = eventResults.totalDonation
        
        let donationTotalCount = donationTotal.count
        print("donationTotalCount: ", donationTotalCount)
        
        for donationSum in donationTotal {
            
        let dSum = donationSum
        dTotal += dSum
        print("dTotal: ", dTotal)
            
        } // for donationSum
        
       print("dTotal total: ", dTotal)
        
       totalDonation.text = String(dTotal)
        
        
        // Get value for Total Attempts
        let attemptsTotal: Array = eventResults.totAttempt
        
        let attemptsCount = donationTotal.count
        print("attemptsCount: ", attemptsCount)
        
        for attemptsSum in attemptsTotal {
            
        let aSum = attemptsSum
        aTotal += aSum
        print("aTotal: ", aTotal)
            
        } // for attemptsSum
        
       print("aTotal total: ", aTotal)
        
       totalAttempts.text = String(aTotal)
       
        
       // Get value for Total Makes
        let makesTotal: Array = eventResults.totMake
        
        let makesCount = makesTotal.count
        print("makesCount: ", makesCount)
        
        for makesSum in makesTotal {
            
        let mSum = makesSum
        mTotal += mSum
        print("mTotal: ", mTotal)
            
        } // for makesSum
        
       print("mTotal total: ", mTotal)
        
       totalMakes.text = String(mTotal)
       
        
        // Calculate value for totalPercentage
        let percent:Double = Double(Double(mTotal)/Double(aTotal))
        let shotPercentage:Double = Double(round(percent*1000)/1000) * 100
        totalPercentage.text = String(shotPercentage)
        
        
        // Get value for Total Per Shot
        let perShotTotal: Array = eventResults.totPerShot
        
        let perShotCount = perShotTotal.count
        print("perShotCount: ", perShotCount)
        
        for perShotSum in perShotTotal {
            
        let pSum = perShotSum
        pTotal += pSum
        print("pTotal: ", pTotal)
            
        } // for perShotSum
        
       print("pTotal total: ", pTotal)
        
       totalPerShot.text = String(pTotal)
       
        
        // Get value for Total Flat Donation
        
        let flatDonationTotal: Array = eventResults.totFlatDon
        
        let flatDonationCount = flatDonationTotal.count
        print("flatDonationCount: ", flatDonationCount)
        
        for flatDonationSum in flatDonationTotal {
            
        let fSum = flatDonationSum
        fTotal += fSum
        print("fTotal: ", fTotal)
            
        } // for flatDonationSum
        
       print("fTotal total: ", fTotal)
        
       totalFlatDonaton.text = String(fTotal)
       
    } // override viewDidLoad
    
    
    var team: String = ""
    
    var eventName: String = ""
    
    var eDate: Date = Date()
    
    var eventTotalsVariable: Bool = false

    var dTotal: Double = 0.0
    var aTotal: Int = 0
    var mTotal: Int = 0
    var pTotal: Double = 0.0
    var fTotal: Double = 0.0
   // var percent: Double = 0.0
    
    @IBOutlet weak var totalDonation: UILabel!
    
    
    @IBOutlet weak var totalAttempts: UILabel!
    
    
    @IBOutlet weak var totalMakes: UILabel!
    
    
    @IBOutlet weak var totalPercentage: UILabel!
    
    
    @IBOutlet weak var totalPerShot: UILabel!
    
    
    @IBOutlet weak var totalFlatDonaton: UILabel!
    
    
    @IBAction func refreshTotals(_ sender: UIButton) {
       
        var dTotal: Double = 0.0
        var aTotal: Int = 0
        var mTotal: Int = 0
        var pTotal: Double = 0.0
        var fTotal: Double = 0.0
        
        
        let eventResults = totalStats.queryEventTotals(tName: team, eName: eventName, eDate: eDate)
        
        // Get value for donationTotal
        let donationTotal: Array = eventResults.totalDonation
        
        let donationTotalCount = donationTotal.count
        print("donationTotalCount: ", donationTotalCount)
        
        for donationSum in donationTotal {
            
        let dSum = donationSum
        dTotal += dSum
        print("dTotal: ", dTotal)
            
        } // for donationSum
        
       print("dTotal total: ", dTotal)
        
       totalDonation.text = String(dTotal)
        
        
        // Get value for Total Attempts
        let attemptsTotal: Array = eventResults.totAttempt
        
        let attemptsCount = donationTotal.count
        print("attemptsCount: ", attemptsCount)
        
        for attemptsSum in attemptsTotal {
            
        let aSum = attemptsSum
        aTotal += aSum
        print("aTotal: ", aTotal)
            
        } // for attemptsSum
        
       print("aTotal total: ", aTotal)
        
       totalAttempts.text = String(aTotal)
       
        
       // Get value for Total Makes
        let makesTotal: Array = eventResults.totMake
        
        let makesCount = makesTotal.count
        print("makesCount: ", makesCount)
        
        for makesSum in makesTotal {
            
        let mSum = makesSum
        mTotal += mSum
        print("mTotal: ", mTotal)
            
        } // for makesSum
        
       print("mTotal total: ", mTotal)
        
       totalMakes.text = String(mTotal)
       
        
        // Calculate value for totalPercentage
        let percent:Double = Double(Double(mTotal)/Double(aTotal))
        let shotPercentage: Double = Double(round(percent*1000)/1000) * 100
        totalPercentage.text = String(shotPercentage)
        
    
        // Get value for Total Per Shot
        let perShotTotal: Array = eventResults.totPerShot
        
        let perShotCount = perShotTotal.count
        print("perShotCount: ", perShotCount)
        
        for perShotSum in perShotTotal {
            
        let pSum = perShotSum
        pTotal += pSum
        print("pTotal: ", pTotal)
            
        } // for perShotSum
        
       print("pTotal total: ", pTotal)
        
       totalPerShot.text = String(pTotal)
       
        
        // Get value for Total Flat Donation
        
        let flatDonationTotal: Array = eventResults.totFlatDon
        
        let flatDonationCount = flatDonationTotal.count
        print("flatDonationCount: ", flatDonationCount)
        
        for flatDonationSum in flatDonationTotal {
            
        let fSum = flatDonationSum
        fTotal += fSum
        print("fTotal: ", fTotal)
            
        } // for flatDonationSum
        
       print("fTotal total: ", fTotal)
        
       totalFlatDonaton.text = String(fTotal)
        
    }  //refreshTotals button
    

} // TotalStatsViewController
