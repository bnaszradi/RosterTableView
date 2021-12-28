//
//  SponsorStatsCollectionViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/29/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class SponsorStatsCollectionViewController: UICollectionViewController {

    
    let sponsorsList = SponsorsList()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
    var team: String = ""
    var player: String = ""
    var eventName: String = ""
    
    var eventDate: Date = Date()

    var sponsorN: String = ""
    var selectedSponsor: String = ""
    
   var donationtotMake: Int = 0
  //  var donationArraytotMake: Array<Int> = []
    
    var resultsSponsorArray: Array<String> = []
    var resultsAmountArray: Array<Double> = []
    var resultsDonationArray: Array<Double> = []
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sponsorsList.sponsorQuery(tName: team, pName: player, eDate: eventDate, eName: eventName, completion: { qsponsorQuery in
            
            
            DispatchQueue.main.async {
            
            self.resultsSponsorArray = qsponsorQuery.resultsSponsorArray
            print("resultsSponsorArray: ", self.resultsSponsorArray)
                    
            self.resultsAmountArray = qsponsorQuery.resultsAmountArray
            print("resultsAmountArray: ", self.resultsAmountArray)
                
            self.resultsDonationArray = qsponsorQuery.resultsDonationArray
            print("resultsDonatonArray: ", self.resultsDonationArray)
                
          //  self.collectionView.reloadData()
          //  print("reloadData")
                                    
        //    }  // DispatchQueue
            
      //  })  // completionhandler sponsorList.sponsorQuery
       
        //  Query dontaton table to get number of makes for player
        self.updateDonationsTotals.querySponsorWithShots(tName: self.team, pName: self.player, eDate: self.eventDate, completion: { qSponsWithShots in
            
            DispatchQueue.main.async {
                
            self.donationtotMake = qSponsWithShots.totMake
            print("donationArray: ", self.donationtotMake)
                
            self.collectionView.reloadData()
            print("reloadData")
                

            } // DispatchQueue
            
        } )  //Completionhandler updateDonationsTotals.querySponsorWithShots
        
            }  // DispatchQueue
            
        })  // completionhandler sponsorList.sponsorQuery
       
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        /*
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        */
        
    } //viewDidLoad

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        var headerView = SponsorStatsReusableView()
       

        if let headerViewText = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewText", for: indexPath) as? SponsorStatsReusableView {
        
        headerViewText.eventN.text = self.eventName
        
        headerView = headerViewText
            
       
        } // if let headerViewText
            
        return headerView
        
    } // collectionView for viewForSupplementary
    
  

   // lazy var resultsArray = sponsorsList.sponsorsQuery(tName: team, pName: player, eDate: eventDate)
    
    
    //need to query to get this number of makes
   // lazy var donationArray = updateDonationsTotals.querySponsorWithShots(tName: team, pName: player, eDate: eventDate)
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let resultsLength = self.resultsSponsorArray.count
        
        return resultsLength
        
    }  //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var sponsorStatsCell = SponssorStatsCollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sponsorStatsCell", for: indexPath) as? SponssorStatsCollectionViewCell {
        
            cell.sponsorName.text = String(self.resultsSponsorArray[indexPath.row])
            
            
         //   cell.makes.text = String(donationArray.totMake)
            cell.makes.text = String(self.donationtotMake)
           // cell.makes.text = String(self.donationArraytotMake[indexPath.row])
            
            // Need to calculate this amount
            
          //  let perShotDonation = (resultsArray.resultsAmountPerArray[indexPath.row]) * Double(donationArray.totMake)
          //  let perShotDonation = (self.resultsAmountArray[indexPath.row]) * Double(self.donationArraytotMake)
            let perShotDonation = (self.resultsAmountArray[indexPath.row]) * Double(self.donationtotMake)
            
            let totDonation = perShotDonation + Double(self.resultsDonationArray[indexPath.row])
            
            cell.totalDonation.text = String(totDonation)
            
            cell.perShot.text = String(self.resultsAmountArray[indexPath.row])
            
            cell.flat.text = String(self.resultsDonationArray[indexPath.row])
        
          sponsorStatsCell = cell
            
        } //configure cell
    
        return sponsorStatsCell
        
    } //cellForAtItem

    
    
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        self.resultsSponsorArray[index.item]
    } //locationItem func
    
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        selectedSponsor = locationItem(at: indexPath)
        print("selectedSponsor: ", selectedSponsor)
      
        performSegue(withIdentifier: "toSponsorPhone", sender: selectedSponsor)
        return true
        
    } // shouldSelectItemAt
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
      //  if let selectedSponsor = sender as? String {
        
        if segue.identifier == "toSponsorPhone" {
        
            let vcTeam = segue.destination as! UINavigationController
           
            let vcStats = vcTeam.viewControllers.first as! SponsorTextViewController
            
            vcStats.name = self.player
            print("player in sponsorSats: ", player)
           
            vcStats.team = self.team
            print("vcStats.team: ", vcStats.team)
            
            vcStats.eventDate = self.eventDate
            print("eventDate in sponsorSats: ", eventDate)
            
            vcStats.sponsorN = self.selectedSponsor
            print("sponsorN in sponsorSats: ", sponsorN)
            
           
            vcStats.eventName = self.eventName
            
            let Title = team
          //  Title.append(" ")
         //   Title.append(selectedSponsor)
          //  Title.append(" ")
           // Title.append(eDate)
            
            vcStats.title = Title
            
      //  print("Title: ", Title)
      //  print("vcStats.team ", vcStats.team)
       // print("eventName: ", eventName)
            
            
        } // if toSponsorPhone segue
      

        
        } // prepare func
    
    
    
    @IBAction func unwindSponsorTextViewControllerCancel(segue: UIStoryboardSegue) {
     
    }  // UIStoryboardSegue
    
    
    
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}  //SponsorStatsCollectionViewController
