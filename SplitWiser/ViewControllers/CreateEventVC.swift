//
//  CreateEventVC.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    
    @IBAction func doneAddingContact(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: {
            print("New Event Created")
        })
    }
    
    @IBOutlet weak var addProfileImageButton: UIImageView!
    
    @IBOutlet weak var enterEventNameField: UITextField!
    
    @IBOutlet weak var addNewUser: UIImageView!
    
    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        userListTableView.delegate = self
//        userListTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let contactCell = userListTableView.dequeueReusableCell(withIdentifier: "contactInfoCell"){
            if let profileImageView = contactCell.viewWithTag(1111) as? UIImageView{
                profileImageView.image = #imageLiteral(resourceName: "PersonPlaceHolder")
            }
            
            if let profileName = contactCell.viewWithTag(2222) as? UILabel{
                profileName.text = "Pavan Kowshik"
            }
            
            if let profileNumber = contactCell.viewWithTag(3333) as? UILabel{
                profileNumber.text = "99789-09086"
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


