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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        /*
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        */
    } //viewDidLoad

    
    let sponsorsList = SponsorsList()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
    var team: String = ""
    var player: String = ""
    var eventName: String = ""
    
    var eventDate: Date = Date()
    
    
    var sponsorN: String = ""
    var selectedSponsor: String = ""
    
    
    let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
     
    
    
    lazy var resultsArray = sponsorsList.sponsorsQuery(tName: team, pName: player, eDate: eventDate)
    
    
    //need to query to get this number of makes
    lazy var donationArray = updateDonationsTotals.querySponsorWithShots(tName: team, pName: player, eDate: eventDate)
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let resultsLength = resultsArray.resultsSponsorArray.count
        
        return resultsLength
        
    }  //numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        var sponsorStatsCell = SponssorStatsCollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sponsorStatsCell", for: indexPath) as? SponssorStatsCollectionViewCell {
        
            cell.sponsorName.text = String(resultsArray.resultsSponsorArray[indexPath.row])
            
            //need to query to get this number of makes
            cell.makes.text = String(donationArray.totMake)
        
            // Need to calculate this amount
            
            let perShotDonation = (resultsArray.resultsAmountPerArray[indexPath.row]) * Double(donationArray.totMake)
            
            
            let totDonation = perShotDonation + Double(resultsArray.resultsDonationArray[indexPath.row])
            
            cell.totalDonation.text = String(totDonation)
            
            cell.perShot.text = String(resultsArray.resultsAmountPerArray[indexPath.row])
            
            cell.flat.text = String(resultsArray.resultsDonationArray[indexPath.row])
        
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
        resultsArray.resultsSponsorArray[index.item]
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
