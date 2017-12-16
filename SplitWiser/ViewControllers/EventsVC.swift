//
//  EventsVC.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/9/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EventsVC: UIViewController {

	@IBAction public func createEvent(_ sender: UIBarButtonItem) {
		print("Create event called!")
		if let u = Auth.auth().currentUser {
			print("🙏🏻 Welcome - \(String(describing: u.displayName))")
			EventManager().createEvent(name: "Lunch@Beijing", description: "", user: u)
		}
	}
}
