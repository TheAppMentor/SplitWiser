//
//  HerokuPersistanceManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/29/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct HerokuPersistanceManager: Persistance {

	func fetch(whereClause: [String:[String]], orderedByClause: String?, tableName: String, completionHandler:@escaping (_ records: [PersistanceConvertible]) -> Void) {
		
	}
	
	func getCurrentLoggedInUser(completionHandler: @escaping (_ user: SplitWiserUser?, _ error: Error?) -> Void) {

	}
	
	func insert(persistanceConvertible: PersistanceConvertible, autoGenerateKey: Bool,completionHandler: @escaping (_ insertionId: String?, _ error: Error?) -> Void) {
		
	}

	func update(persistanceConvertible: PersistanceConvertible, columnsToBeUpdated: [String],completionHandler: @escaping (_ success: Bool) -> Void) {
		
	}

	func delete(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (Bool) -> Void) {

	}
	
	func batchUpdate(persistanceConvertibles: [PersistanceConvertible],columnsToBeUpdated:[String],completionHandler:@escaping (_ success: Bool) -> Void) {
		
	}
}
