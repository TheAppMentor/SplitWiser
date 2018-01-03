//
//  AllEventsListTVC.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 26/12/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import PHDiff

extension Event : Diffable{
    var diffIdentifier: String {
        return self.eventId
    }
    
    typealias HashType = String
}

class AllEventsListTVC: UITableViewController {

	var allEvents: [Event] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchDataAndReloadTable), for: UIControlEvents.valueChanged)
        navigationItem.searchController = searchController
        
        fetchDataAndReloadTable(shouldAnimate: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDataAndReloadTable(shouldAnimate: true)
    }
    
    @objc func fetchDataAndReloadTable(shouldAnimate : Bool){
        UserManager().currentLoggedInUser(completionHandler: {(user, userError) in
            user?.getEvents(completionHandler: {(events, eventError) in
                
                if shouldAnimate == true {
                    self.reloadTableViewWithChamakAnimations(newEventList: events!.reversed())
                }else {
                    self.allEvents = events!.reversed() //TODO: Pavan/Reshma, is there way to get the events in reverse by date from Firebase.
                    self.tableView.reloadData()
                }
                
                if self.refreshControl?.isRefreshing == true{
                    self.refreshControl?.endRefreshing()
                }
            })
        })
    }
    
    func reloadTableViewWithChamakAnimations(){
        // Temporary fix, remove this after we figure out the batch updates thing.
        self.tableView.reloadData()

        
        tableView.performBatchUpdates({
            
            //Process all Additions
            
            
            //Process all Deletes
            
            
            //Process all Moves.
            
        }) { (success) in
            print("Successfully finished loading the table view.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell", for: indexPath)

        if let eventListView = cell.viewWithTag(1111) as? EventDetailsView{
         
//            @IBOutlet weak var profilePicButton: UIButton!
//            @IBOutlet weak var eventName: UITextField!
//            @IBOutlet weak var participantListView: ParticipantListView!

            eventListView.profilePicButton.setImage(#imageLiteral(resourceName: "PersonPlaceHolder"), for: .normal)
            eventListView.eventName.text = allEvents[indexPath.row].name
            eventListView.eventDescription.text = allEvents[indexPath.row].description
            
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func reloadTableViewWithChamakAnimations(newEventList: [Event]){
        let steps = PHDiff.steps(fromArray: self.allEvents, toArray: newEventList)
        
        if steps.count > 0 {
            tableView.beginUpdates()
            self.allEvents = newEventList // update your model here
            
            var insertions: [IndexPath] = []
            var deletions: [IndexPath] = []
            var reloads: [IndexPath] = []
            
            steps.forEach { step in
                switch step {
                case let .insert(_, index):
                    insertions.append(IndexPath(row: index, section: 0))
                case let .delete(_, index):
                    deletions.append(IndexPath(row: index, section: 0))
                case let .move(_, fromIndex, toIndex):
                    deletions.append(IndexPath(row: fromIndex, section: 0))
                    insertions.append(IndexPath(row: toIndex, section: 0))
                case let .update(_, index):
                    reloads.append(IndexPath(row: index, section: 0))
                }
            }
            
            tableView.insertRows(at: insertions, with: .automatic)
            tableView.deleteRows(at: deletions, with: .automatic)
            tableView.reloadRows(at: reloads, with: .automatic)
            
            tableView.endUpdates()
        }
    }


}
