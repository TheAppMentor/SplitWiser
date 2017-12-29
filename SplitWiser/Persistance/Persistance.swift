//
//  Persistance.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/16/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

protocol Persistance {
	func insert(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ insertionId: String?,_ error: Error?) -> Void)
	func retrieve() -> PersistanceConvertible?
	func update(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void)
	func delete(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void)
}

protocol PersistanceConvertible {
	//values to be inserted/updated into the table.
	//key is the column name, value is the value to be inserted
	func getColumnNamevalueDictionary() -> [String : Any]
	
	//Id of the row to be deleted/updated from the table
	func getIdToBeModified() -> String
	
	//Id of the row to be updated from the table
	
	//table on which the CRUD operations are to be performed
	func getTableName() -> String
}
