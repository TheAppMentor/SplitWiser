//
//  HerokuPersistanceManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/29/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct HerokuPersistanceManager: Persistance {

	func getEventWith(eventId: String, completionHandler: @escaping (Event?, Error?) -> Void) {
		
	}

	func createUser(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (String?, Error?) -> Void) {
		
	}

	func getCurrentLoggedInUser(completionHandler:@escaping (_ user: SplitWiserUser?,_ error: Error?) -> Void) {

	}

	func getUserWith(userId: String, completionHandler: @escaping (SplitWiserUser?, Error?) -> Void) {

	}
    
	func insert(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (String?, Error?) -> Void) {

	}

	func update(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void) {
		
	}

	func delete(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (Bool) -> Void) {

	}
}
