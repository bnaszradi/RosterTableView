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
    

    let totalStats = TotalStats()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventN.text = eventName
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
      //  dateFormatter.dateFormat = "EEEE MMM d, yyyy"
       // dateFormatter.timeStyle = .short
        
       let eventDate =  dateFormatter.string(from: eDate)
        
        eventD.text =  eventDate
        
       // let eventResults = totalStats.queryEventTotals(tName: team, eName: eventName, eDate: eDate)
        
        totalStats.queryEventTotals(tName: team, eName: eventName, eDate: eDate, completion: { qqueryEventTotals in
                             
            DispatchQueue.main.async {
            
        // Get value for donationTotal
      //  let donationTotal: Array = eventResults.totalDonation
        let donationTotal: Array = qqueryEventTotals.totalDonationArray
        
        let donationTotalCount = donationTotal.count
        print("donationTotalCount: ", donationTotalCount)
        
        for donationSum in donationTotal {
            
        let dSum = donationSum
            self.dTotal += dSum
            print("dTotal: ", self.dTotal)
            
        } // for donationSum
        
        print("dTotal total: ", self.dTotal)
        
        self.totalDonation.text = String(self.dTotal)
        
        
        // Get value for Total Attempts
      //  let attemptsTotal: Array = eventResults.totAttempt
        let attemptsTotal: Array = qqueryEventTotals.totAttemptArray
                
        
        let attemptsCount = donationTotal.count
        print("attemptsCount: ", attemptsCount)
        
        for attemptsSum in attemptsTotal {
            
        let aSum = attemptsSum
            self.aTotal += aSum
            print("aTotal: ", self.aTotal)
            
        } // for attemptsSum
        
        print("aTotal total: ", self.aTotal)
        
        self.totalAttempts.text = String(self.aTotal)
       
        
       // Get value for Total Makes
       // let makesTotal: Array = eventResults.totMake
        let makesTotal: Array = qqueryEventTotals.totMakeArray
        
        let makesCount = makesTotal.count
        print("makesCount: ", makesCount)
        
        for makesSum in makesTotal {
            
        let mSum = makesSum
            self.mTotal += mSum
            print("mTotal: ", self.mTotal)
            
        } // for makesSum
        
        print("mTotal total: ", self.mTotal)
        
        self.totalMakes.text = String(self.mTotal)
       
        
        // Calculate value for totalPercentage
        let percent:Double = Double(Double(self.mTotal)/Double(self.aTotal))
        let shotPercentage:Double = Double(round(percent*1000)/1000) * 100
                self.totalPercentage.text = String(shotPercentage)
        
        
        // Get value for Total Per Shot
       // let perShotTotal: Array = eventResults.totPerShot
        let perShotTotal: Array = qqueryEventTotals.totPerShotArray
                
        
        let perShotCount = perShotTotal.count
        print("perShotCount: ", perShotCount)
        
        for perShotSum in perShotTotal {
            
        let pSum = perShotSum
            self.pTotal += pSum
            print("pTotal: ", self.pTotal)
            
        } // for perShotSum
        
        print("pTotal total: ", self.pTotal)
        
        self.totalPerShot.text = String(self.pTotal)
       
        
        // Get value for Total Flat Donation
        
     //   let flatDonationTotal: Array = eventResults.totFlatDon
        let flatDonationTotal: Array = qqueryEventTotals.totFlatDonArray
        
        let flatDonationCount = flatDonationTotal.count
        print("flatDonationCount: ", flatDonationCount)
        
        for flatDonationSum in flatDonationTotal {
            
        let fSum = flatDonationSum
            self.fTotal += fSum
            print("fTotal: ", self.fTotal)
            
        } // for flatDonationSum
        
        print("fTotal total: ", self.fTotal)
        
        self.totalFlatDonaton.text = String(self.fTotal)
       
                
            }   // DispatchQueue
            
        }  )  // Completionhandler totalStats.queryEventTotals
                
                
    } // override viewDidLoad
    
    
    @IBOutlet weak var eventN: UILabel!
    
    @IBOutlet weak var eventD: UILabel!
    
    
    @IBOutlet weak var totalDonation: UILabel!
    
    
    @IBOutlet weak var totalAttempts: UILabel!
    
    
    @IBOutlet weak var totalMakes: UILabel!
    
    
    @IBOutlet weak var totalPercentage: UILabel!
    
    
    @IBOutlet weak var totalPerShot: UILabel!
    
    
    @IBOutlet weak var totalFlatDonaton: UILabel!
    
    
    @IBAction func refreshTotals(_ sender: UIButton) {
       
        
        dTotal = 0.0
        aTotal = 0
        mTotal = 0
        pTotal = 0.0
        fTotal = 0.0
        
        
        totalStats.queryEventTotals(tName: team, eName: eventName, eDate: eDate, completion: { qqueryEventTotals in
                
           
            DispatchQueue.main.async {
            
                
        // Get value for donationTotal
      //  let donationTotal: Array = eventResults.totalDonation
        let donationTotal: Array = qqueryEventTotals.totalDonationArray
        
        let donationTotalCount = donationTotal.count
        print("donationTotalCount: ", donationTotalCount)
        
        for donationSum in donationTotal {
            
        let dSum = donationSum
            self.dTotal += dSum
            print("dTotal: ", self.dTotal)
            
        } // for donationSum
        
        print("dTotal total: ", self.dTotal)
        
        self.totalDonation.text = String(self.dTotal)
        
        
        // Get value for Total Attempts
      //  let attemptsTotal: Array = eventResults.totAttempt
        let attemptsTotal: Array = qqueryEventTotals.totAttemptArray
                
        
        let attemptsCount = donationTotal.count
        print("attemptsCount: ", attemptsCount)
        
        for attemptsSum in attemptsTotal {
            
        let aSum = attemptsSum
            self.aTotal += aSum
            print("aTotal: ", self.aTotal)
            
        } // for attemptsSum
        
        print("aTotal total: ", self.aTotal)
        
        self.totalAttempts.text = String(self.aTotal)
       
        
       // Get value for Total Makes
       // let makesTotal: Array = eventResults.totMake
        let makesTotal: Array = qqueryEventTotals.totMakeArray
        
        let makesCount = makesTotal.count
        print("makesCount: ", makesCount)
        
        for makesSum in makesTotal {
            
        let mSum = makesSum
            self.mTotal += mSum
            print("mTotal: ", self.mTotal)
            
        } // for makesSum
        
        print("mTotal total: ", self.mTotal)
        
        self.totalMakes.text = String(self.mTotal)
       
        
        // Calculate value for totalPercentage
        let percent:Double = Double(Double(self.mTotal)/Double(self.aTotal))
        let shotPercentage:Double = Double(round(percent*1000)/1000) * 100
                self.totalPercentage.text = String(shotPercentage)
        
        
        // Get value for Total Per Shot
       // let perShotTotal: Array = eventResults.totPerShot
        let perShotTotal: Array = qqueryEventTotals.totPerShotArray
                
        
        let perShotCount = perShotTotal.count
        print("perShotCount: ", perShotCount)
        
        for perShotSum in perShotTotal {
            
        let pSum = perShotSum
            self.pTotal += pSum
            print("pTotal: ", self.pTotal)
            
        } // for perShotSum
        
        print("pTotal total: ", self.pTotal)
        
        self.totalPerShot.text = String(self.pTotal)
       
        
        // Get value for Total Flat Donation
        
     //   let flatDonationTotal: Array = eventResults.totFlatDon
        let flatDonationTotal: Array = qqueryEventTotals.totFlatDonArray
        
        let flatDonationCount = flatDonationTotal.count
        print("flatDonationCount: ", flatDonationCount)
        
        for flatDonationSum in flatDonationTotal {
            
        let fSum = flatDonationSum
            self.fTotal += fSum
            print("fTotal: ", self.fTotal)
            
        } // for flatDonationSum
        
        print("fTotal total: ", self.fTotal)
        
        self.totalFlatDonaton.text = String(self.fTotal)
       
                
            }   // DispatchQueue
            
        }  )  // Completionhandler totalStats.queryEventTotals
       
        
        
        
        /*
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
    */
        
        
    }  //refreshTotals button
    

} // TotalStatsViewController
