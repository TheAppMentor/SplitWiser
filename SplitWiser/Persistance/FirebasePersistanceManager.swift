//
//  FirebasePersistanceManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/16/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct FirebasePersistanceManager: Persistance {
	
	func fetch(whereClause: [String:[String]], orderedByClause: String?, tableName: String, completionHandler: @escaping (_ records: [PersistanceConvertible]) -> Void) {
		let values = whereClause[whereClause.keys.first!]!
		let ref = Database.database().reference(withPath: tableName)
		var dataBaseQuery:DatabaseQuery!
		if let orderBy = orderedByClause {
			dataBaseQuery = ref.queryOrdered(byChild: orderBy)
		} else {
			dataBaseQuery = ref.queryOrderedByKey()
		}
		if values.count >= 2 {
			dataBaseQuery = dataBaseQuery.queryStarting(atValue: values[0]).queryEnding(atValue: values[values.count - 1])
		} else {
			dataBaseQuery = dataBaseQuery.queryEqual(toValue: values[0]);
		}
		dataBaseQuery.observeSingleEvent(of: .value) { (dataSnapShot) in
			switch(tableName) {
			case USERCONSTANTS.DB_PATH:
				completionHandler(self.buildUsersFrom(dataSnapShot: dataSnapShot))
			case EVENTCONSTANTS.DB_PATH:
				completionHandler(self.buildEventsFrom(dataSnapShot: dataSnapShot))
			case TRANSACTIONCONSTANTS.DB_PATH:
				completionHandler(self.buildTransactionsFrom(dataSnapShot: dataSnapShot))
			default:
				print("Error")
			}
		}
	}
	
	func insert(persistanceConvertible: PersistanceConvertible,autoGenerateKey:Bool,completionHandler:@escaping (_ insertionId: String?,_ error: Error?) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		var key = ""
		if autoGenerateKey {
			key = eventRef.childByAutoId().key
		} else {
			key = persistanceConvertible.getId()
		}
		let entry = persistanceConvertible.getColumnNamevalueDictionary()
		let updates = ["\(key)": entry] as [String : Any]
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			completionHandler(key,error)
		})
	}

	func getCurrentLoggedInUser(completionHandler:@escaping (_ user: SplitWiserUser?,_ error: Error?) -> Void) {
		if let u = Auth.auth().currentUser {
			var whereClause = [String:[String]]()
			whereClause["id"] = [u.phoneNumber!]
			self.fetch(whereClause: whereClause, orderedByClause: nil, tableName: USERCONSTANTS.DB_PATH, completionHandler: { (persistanceArray) in
				if persistanceArray.count == 0 {
					completionHandler(nil, UserError.noSuchUser)
				} else {
					completionHandler((persistanceArray as! [SplitWiserUser])[0] , nil)
				}
			})
		} else {
			completionHandler(nil, UserError.noSuchUser)
		}
	}
	
	func update(persistanceConvertible: PersistanceConvertible,columnsToBeUpdated:[String],completionHandler:@escaping (_ success: Bool) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		let key = persistanceConvertible.getId()
		let entry = persistanceConvertible.getColumnNamevalueDictionary()
		var updates = [String:Any]()
		for columnName in entry.keys {
			if columnsToBeUpdated.index(of: columnName) != nil {
				updates["\(key)/\(columnName)"] = entry[columnName] as Any
			}
		}
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				completionHandler(false)
			} else {
				completionHandler(true)
			}
		})
	}
	
	func batchUpdate(persistanceConvertibles: [PersistanceConvertible],columnsToBeUpdated:[String],completionHandler:@escaping (_ success: Bool) -> Void) {
		var tableName:String!
		var updates = [String:Any]()
		
		for persistanceConvertible in persistanceConvertibles {
			tableName = persistanceConvertible.getTableName()
			let key = persistanceConvertible.getId()
			let entry = persistanceConvertible.getColumnNamevalueDictionary()
			for columnName in entry.keys {
				if columnsToBeUpdated.index(of: columnName) != nil {
					updates["\(key)/\(columnName)"] = entry[columnName] as Any
				}
			}
		}
		let eventRef = Database.database().reference(withPath: tableName)
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				completionHandler(false)
			} else {
				completionHandler(true)
			}
		})
	}
	
	func delete(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		let node = eventRef.child(persistanceConvertible.getId())
		node.removeValue(completionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				completionHandler(false)
			} else {
				completionHandler(true)
			}
		})
	}
}

//MARK: utility methods to get array of events, transactions or users
extension FirebasePersistanceManager {
	
	func buildEventsFrom(dataSnapShot: DataSnapshot) -> [PersistanceConvertible] {
		var events = [PersistanceConvertible]()
		if let snapshots = dataSnapShot.children.allObjects as? [DataSnapshot] {
			for child in snapshots {
				if let dataDict = child.value as? Dictionary<String, Any> {
					var dataDict = dataDict
					dataDict["id"] = child.key as Any
					let event = Event(dataDictonary: dataDict)
					events.append(event)
				}
			}
		}
		return events
	}
	
	func buildUsersFrom(dataSnapShot: DataSnapshot) -> [PersistanceConvertible] {
		var users = [PersistanceConvertible]()
		if let snapshots = dataSnapShot.children.allObjects as? [DataSnapshot] {
			for child in snapshots {
				if let dataDict = child.value as? Dictionary<String, Any> {
					var dataDict = dataDict
					dataDict["id"] = child.key as Any
					let user = SplitWiserUser(dataDictonary: dataDict)
					users.append(user)
				}
			}
		}
		return users
	}
	
	func buildTransactionsFrom(dataSnapShot: DataSnapshot) -> [PersistanceConvertible] {
		var transactions = [PersistanceConvertible]()
		if let snapshots = dataSnapShot.children.allObjects as? [DataSnapshot] {
			for child in snapshots {
				if let dataDict = child.value as? Dictionary<String, Any> {
					var dataDict = dataDict
					dataDict["id"] = child.key as Any
					let transaction = Transaction(dataDictonary: dataDict)
					transactions.append(transaction)
				}
			}
		}
		return transactions
	}
}
