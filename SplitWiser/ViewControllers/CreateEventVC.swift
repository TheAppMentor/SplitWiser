//
//  CreateEventVC.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import ZAlertView
import Firebase
import FirebaseAuth
import Contacts

class CreateEventVC: UIViewController, EventDetailsDelegate {
    
    struct EventDetails {
        var eventName : String?
        var eventDetails : String?
    }
    
    private var _allContacts : [CNContact]?
    
    var allContacts : [CNContact] {
        if _allContacts == nil {
            _allContacts = ContactManager().fetchAllContacts()
        }
        return _allContacts ?? [CNContact]()
    }
    
    var createdEvent : EventDetails = EventDetails()
    
    @IBAction func doneAddingContact(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: {
            print("New Event Created")
        })
    }
    @IBOutlet weak var eventDetailsView: EventDetailsView!
    
    @IBOutlet weak var addNewUser: UIImageView!
    
    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        userListTableView.delegate = self
//        userListTableView.dataSource = self
        
        //self.navigationController?.navigationBar.set = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(cancelAddingEvent(sender:)))
        
        eventDetailsView.delegate = self
    }

    
    @IBAction func doneAddingEvent(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true) {
            print("Create event called!")
			UserManager().currentLoggedInUser(completionHandler: {(user, userError) in
				EventManager().createEvent(name: self.createdEvent.eventName!, description: self.createdEvent.eventDetails, user: user!, completionHandler: {(event, eventError) in
                    print("CreateEventVC : Finished creating event.")
                    })
                })
            }
        }
    
    @IBAction func cancelEventAdd(_ sender: UIBarButtonItem) {
        
        ZAlertView.positiveColor = UIColor.clear
        ZAlertView.negativeColor = UIColor.clear
        ZAlertView.buttonFont = UIFont(name: "HelveticaNeue", size: 17)
        ZAlertView.buttonTitleColor = UIColor(red: (65.0/255.0), green: (131.0/255.0), blue: (215.0/255.0), alpha: 1.0)
        ZAlertView.titleColor = UIColor(red: (102.0/255.0), green: (102.0/255.0), blue: (102.0/255.0), alpha: 1.0)
        
        let dialog = ZAlertView(title: "Discard Event?", message: "The Event  will NOT be saved. Are you sure you want cancel?", okButtonText: "Yes, cancel it", cancelButtonText: "No, take me back")
        dialog.width = self.view.frame.width * 0.9
        //dialog.cancelHandler = self.closeScreen
        dialog.okHandler = self.closeScreen
        
        dialog.show()
    }
    
    func closeScreen(theAlertView : ZAlertView) -> () {
        theAlertView.dismissAlertView()
        dismiss(animated: true) {
            print("Cancelled Event Add !!!")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateEventVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let contactCell = userListTableView.dequeueReusableCell(withIdentifier: "contactInfoCell"){
            
            
            let theContact = allContacts[indexPath.row]
            
            if let profileImageView = contactCell.viewWithTag(1111) as? UIImageView{
                profileImageView.image = #imageLiteral(resourceName: "PersonPlaceHolderNoGender")
                if let imgData = theContact.imageData {
                    if let theImage = UIImage.init(data: imgData){
                        profileImageView.image = theImage
                    }
                }
            }
            
            if let profileName = contactCell.viewWithTag(2222) as? UILabel{
                profileName.text = theContact.givenName + " " + theContact.familyName
            }
            
            if let profileNumber = contactCell.viewWithTag(3333) as? UILabel{
                profileNumber.text = theContact.phoneNumbers.first?.value.stringValue ?? "Not Found"
            }
            
            if let isSelected = contactCell.viewWithTag(4444) as? UIImageView{
                if indexPath.row == 2 || indexPath.row == 4{
                    isSelected.image = nil
                }
            }
            
            return contactCell
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }

}


extension CreateEventVC{
    func didEnterEventName(eventName : String){
        print(#function)
        print("Did add event with Name : \(eventName)")
        createdEvent.eventName = eventName
        
    }
    
    func didEnterEventDescription(eventDescription : String){
        
    }
    
    func didAddEventProfilePic(profilePic : UIImage){
        
    }
    
    func didAddUserToEvent(userID : UUID){
        
    }
}


extension CreateEventVC{
    
    var participantList : [ParticipantRepresentable]{
        
        let list = [Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "PK"),
                    Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "RR"),
                    Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "PM"),
                    Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "EM"),
                    Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "RD"),
                    Participant(profileImage: #imageLiteral(resourceName: "PersonPlaceHolder"), shortDisplayName: "TZ")]
        
        return list
    }
}

struct Participant : ParticipantRepresentable {
    var profileImage: UIImage? = #imageLiteral(resourceName: "PersonPlaceHolder")
    var shortDisplayName: String = "XX"
}


