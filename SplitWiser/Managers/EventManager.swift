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

	func createEvent(name: String, description: String? = "", user: SplitWiserUser, completionHandler: @escaping (Event?, Error?) -> Void) {
		var event = Event(name: name, description: description, createdBy: user)
		let key = eventRef.childByAutoId().key
		let entry = ["name": event.name,
					 "description": event.description,
					 "date": event.date,
					 "createdBy": event.createdBy.uid as Any] as [String : Any]
		let updates = ["\(key)": entry] as [String : Any]
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				print("🔆🔆🔆 EVENT CREATION ERROR - " + (error?.localizedDescription)!)
				completionHandler(nil, EventError.genericError)
			} else {
				print("🔆🔆🔆 EVENT CREATED - "+key)
				event.eventId = key
				let values = ["\(key)": true]
				let eventUserMappingRef = Database.database().reference(withPath: EVENTCONSTANTS.EVENT_USER_MAPPING+"/"+event.createdBy.uid)
				eventUserMappingRef.updateChildValues(values, withCompletionBlock: {(mappingError: Error?, mappingDbRef: DatabaseReference) in
					if mappingError != nil {
						print("🔆🔆🔆 MAPPING CREATION ERROR - " + (error?.localizedDescription)!)
					} else {
						print("🔆🔆🔆 MAPPING CREATED")
					}
				})
				completionHandler(event, nil)
			}
		})
	}

	func deleteEvent(event: Event, completionHandler: @escaping (Error?) -> Void) {
		let node = eventRef.child(event.eventId!)
		node.removeValue(completionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				print("🔆🔆🔆 " + (error?.localizedDescription)!)
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
	
	func fetchEventsFor(user: SplitWiserUser, completionHandler: @escaping ([Event]?, Error?) -> Void) {
		let eventUserMappingRef = Database.database().reference(withPath: EVENTCONSTANTS.EVENT_USER_MAPPING+"/"+user.uid)
		eventUserMappingRef.observeSingleEvent(of: .value, with: {(snapshot) in
			print("🔆🔆 FOUND IT! ")
			var arrayOfEvents = [Event]()
			if let eventIds = (snapshot.value as? NSDictionary)?.allKeys as? [String] {
				var count = 0
				for eventId in eventIds {
					count = count + 1
					self.eventRef.child(eventId).observeSingleEvent(of: .value, with: {(datasnapshot) in
						if let properties = datasnapshot.value as? NSDictionary {
							let name = properties["name"] as? String
							let description = properties["description"] as? String
							print("🔆🔆🔆🔆 \(String(describing: name)) ")
							let event = Event(name: name!, description: description, createdBy: user)
							arrayOfEvents.append(event)
							if count == eventIds.count {
								completionHandler(arrayOfEvents, nil)
							}
						}
					})
				}
			}
		}) {(error) in
			print("🔆🔆🔆 " + error.localizedDescription)
			completionHandler(nil, EventError.genericError)
		}
	}

}
