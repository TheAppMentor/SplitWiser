//
//  EventManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct EventManager {

	func createEvent(name: String, description: String? = "") -> Bool {
		let success = false
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
