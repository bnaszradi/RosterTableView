//
//  SponsorListViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/25/21.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class SponsorListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    } // viewDidLoad

    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    var team = ""
    var playerName = ""
    var eventName = ""
    var eventDate = Date()
    var selectedSponsor = ""
    
    
    // Add Datasource
    
    let sponsorList = SponsorsList()
    
    
    
    lazy var resultsArray = sponsorList.sponsorsQuery(tName: team, pName: playerName, eDate: eventDate)
    
    
    // Code for selecting cell
    func locationItem(at index:IndexPath) -> String {
        resultsArray.resultsSponsorArray[index.item]
    } //locationItem func
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    } // numberOfSections


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let resultsLength = resultsArray.resultsSponsorArray.count
        
        return resultsLength
    } // numberOfItemsInSection

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var sponsorsCell = SponsorListCollectionViewCell()
        
        if let sponsorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sponsorCell", for: indexPath) as? SponsorListCollectionViewCell {
        
        
            sponsorCell.sponsorName.text = String(resultsArray.resultsSponsorArray[indexPath.row])
            
            sponsorCell.amountPerShot.text = String(resultsArray.resultsAmountPerArray[indexPath.row])
            
            sponsorCell.donation.text = String(resultsArray.resultsDonationArray[indexPath.row])
            
        
           sponsorsCell = sponsorCell
    
        } // sponsorCell
            
        return sponsorsCell

    }  // cellForItemAt

    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        selectedSponsor = locationItem(at: indexPath)
        print("selectedSponsor: ", selectedSponsor)
      
        performSegue(withIdentifier: "toSponsorText", sender: selectedSponsor)
        
        return true
    } //shouldSelectItemAt
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "toSponsorMgmt" {
          
                    print("toSponsorMgmt Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcMgmt = vcEvents.viewControllers.first as! SponsorMgmtViewController
                    
             
            print("vcMgmt.team ", team)
            
            
         //   var Title = team
       // Title.append(" ")
       // Title.append(playerName)
         let Title = playerName
            
            vcMgmt.title = Title
            vcMgmt.name = self.playerName
            vcMgmt.team = team
            
        
        print("Title: ", Title)
        print("vcMgmt.team ", vcMgmt.team)
        print("eventName: ", eventName)
                
                
        vcMgmt.eventName = self.eventName
           
        vcMgmt.eventDate = self.eventDate

                    
                } // to SponsorMgmtController
          
        
        //To SponsorTextViewController
        
        if segue.identifier == "toSponsorText" {
          
                    print("toSponsorText Segue")
             
                    let vcEvents = segue.destination as! UINavigationController
                   
                    let vcText = vcEvents.viewControllers.first as! SponsorTextViewController
                    
             
            print("vcText.team ", team)
            
            
            let Title = team
        
       // Title.append(" ")
       // Title.append(playerName)
            
            vcText.title = Title
            vcText.name = self.playerName
            vcText.team = team
            
        
        print("Title: ", Title)
        print("vcMgmt.team ", vcText.team)
        print("eventName: ", eventName)
                
                
        vcText.eventName = self.eventName
           
        vcText.eventDate = self.eventDate
            
        vcText.sponsorN = self.selectedSponsor

                    
                } // to SponsorTextViewController
          
        
            
        } // prepare func
   
    
    
    
    
    
    @IBAction func unwindSponsorMgmtViewControllerCancel(segue:UIStoryboardSegue) {
        
        //Reload collectionView 
       // resultsArray = manager.eventsQuery(tName: team)
            
        
        resultsArray = sponsorList.sponsorsQuery(tName: team, pName: playerName, eDate: eventDate)
        
        self.collectionView.reloadData()
          
        
       } //unwindSponsorMgmt
    
    
    @IBAction func unwindSponsorTextViewControllerCancel(segue:UIStoryboardSegue) {
        
    } //unwindSponsorTextViewControllerCancel
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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

}  //SponsorListViewController