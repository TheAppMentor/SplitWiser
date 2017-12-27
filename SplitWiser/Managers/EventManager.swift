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

	let persistanceManager = FirebasePersistanceManager()

	func createEvent(name: String, description: String? = "", user: SplitWiserUser, completionHandler: @escaping (Event?, Error?) -> Void) {
		let event = Event(name: name, description: description, createdBy: user)
		persistanceManager.insert(persistanceConvertible: event) { (insertionId,success) in
			
		}
	}

	func deleteEvent(event: Event, completionHandler: @escaping (Error?) -> Void) {
		persistanceManager.delete(persistanceConvertible: event) { (success) in
			if success {
				completionHandler(nil)
			} else {
				completionHandler(EventError.genericError)
			}
		}
	}

	func getDetailsOfEvent(id: UUID) -> Event? {
		return nil
	}
	
	func fetchEventsFor(user: SplitWiserUser, completionHandler: @escaping ([Event]?, Error?) -> Void) {
		//will refactor
		/*let eventUserMappingRef = Database.database().reference(withPath: EVENTCONSTANTS.EVENT_USER_MAPPING+"/"+user.uid)
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
		}*/
	}

}
