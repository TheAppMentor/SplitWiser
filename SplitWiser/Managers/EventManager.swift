//
//  EventManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct EventManager {

	let eventRef = Database.database().reference(withPath: EVENTCONSTANTS.DB_PATH)

	func createEvent(name: String, description: String? = "", user: SplitWiserUser) -> Bool {
		let success = false
		let event = Event(name: name, description: description, createdBy: user)
		eventRef.setValue("Where am I")
		return success
	}

	func deleteEvent(id: UUID) -> Bool {
		let success = false
		return success
	}

	func getDetailsOfEvent(id: UUID) -> Event? {
		return nil
	}
	
	func getEventsFor(user:SplitWiserUser) -> [Event]? {
		return nil
	}

}
