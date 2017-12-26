//
//  EventManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct EventManager {

	let eventRef = Database.database().reference(withPath: EVENTCONSTANTS.DB_PATH)

	func createEvent(name: String, description: String? = "", user: SplitWiserUser, completionHandler: @escaping (Event, Error?) -> Void) {
		var event = Event(name: name, description: description, createdBy: user)
		let key = eventRef.childByAutoId().key
		let entry = ["name": event.name,
					 "description": event.description,
					 "date": event.date,
					 "createdBy": event.createdBy.email as Any] as [String : Any]
		let updates = ["\(key)": entry] as [String : Any]
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				print("🔆🔆🔆 "+(error?.localizedDescription)!)
				completionHandler(event, EventError.genericError)
			} else {
				print("🔆🔆🔆 CREATED - "+key)
				event.eventId = key
				completionHandler(event, nil)
			}
		})
	}

	func deleteEvent(event: Event, completionHandler: @escaping (Error?) -> Void) {
		let node = eventRef.child(event.eventId!)
		node.removeValue(completionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				print("🔆🔆🔆 "+(error?.localizedDescription)!)
				completionHandler(EventError.genericError)
			} else {
				print("🔆🔆🔆 DELETED!")
				completionHandler(nil)
			}
		})
	}

	func getDetailsOfEvent(id: UUID) -> Event? {
		return nil
	}
	
	func getEventsFor(user: SplitWiserUser) -> [Event]? {
		return nil
	}

}
