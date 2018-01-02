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

	private let persistanceManager: Persistance = PersistanceFactory.getPersistanceManager()

	func createEvent(name: String, description: String? = "", user: SplitWiserUser, completionHandler: @escaping (Event?, Error?) -> Void) {
		let event = Event(name: name, description: description, createdBy: user.uid)
		persistanceManager.insert(persistanceConvertible: event) { (insertionId, error) in
			if error == nil {
				var mutatingUser = user
				mutatingUser.events.append(insertionId!)
				self.persistanceManager.update(persistanceConvertible: mutatingUser, completionHandler: {(success) in
					if success {
						completionHandler(event, nil)
					}
				})
			} else {
				completionHandler(nil, EventError.creationFailed)
			}
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

	func getDetailsOfEvent(id: String) -> Event? {
		return nil
	}
	
	func fetchEventsFor(user: SplitWiserUser, completionHandler: @escaping ([Event]?, Error?) -> Void) {
		var events = [Event]()
		if user.events.count == 0 {
			completionHandler(events, nil)
		} else {
			for eventId in user.events {
				persistanceManager.getEventWith(eventId: eventId, completionHandler: {(event, error) in
					if error == nil {
						events.append(event!)
					} else {
						completionHandler(events, error)
					}
					if events.count == user.events.count {
						completionHandler(events, nil)
					}
				})
			}
		}
	}

}
