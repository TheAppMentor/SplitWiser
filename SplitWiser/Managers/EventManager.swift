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

	func createEvent(name: String, description: String? = "", user: SplitWiserUser, members: [SplitWiserUser]? = [], completionHandler: @escaping (Event?, Error?) -> Void) {
		var arrayOfMembers = members ?? []
		var membersList = [String]()
		for member in arrayOfMembers {
			membersList.append(member.getId())
		}
		membersList.append(user.getId())
		let event = Event(name: name, description: description, createdBy: user.uid, members: membersList)
		persistanceManager.insert(persistanceConvertible: event, autoGenerateKey: true) { (insertionId, error) in
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
			
			var whereClause = [String:[String]]()
			whereClause["id"] = user.events
			persistanceManager.fetch(whereClause: whereClause, orderedByClause: "id", tableName: EVENTCONSTANTS.DB_PATH, completionHandler: { (persistanceArray) in
				events = persistanceArray as! [Event]
				completionHandler(events , nil)
			})
		}
	}

}
