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

	@IBOutlet public var eventName: UITextField!

	@IBAction public func createEvent(_ sender: UIBarButtonItem) {
		print("Create event called!")
		if let u = Auth.auth().currentUser {
			print("🙏🏻 Welcome - \(String(describing: u.displayName)) with uid - \(u.uid)")
			let user = SplitWiserUser(uid: u.uid, phoneNumber: u.phoneNumber ?? "", userName: u.displayName!, profileImage: nil, email: u.email, transactionsProvider: TransactionManager.shared, eventsProvider: EventManager())
			EventManager().createEvent(name: eventName.text!, user: user, completionHandler: {(event, error) in
				
			})
		}
	}
}
