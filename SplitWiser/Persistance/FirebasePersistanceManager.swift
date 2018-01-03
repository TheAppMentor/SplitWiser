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
	
	func fetch(whereClause: [String:[String]], orderedByClause: String, tableName: String, completionHandler: @escaping (_ records: [PersistanceConvertible]) -> Void) {
		let values = whereClause[whereClause.keys.first!]!
		let ref = Database.database().reference(withPath: tableName)
		var dataBaseQuery:DatabaseQuery!
		if values.count >= 2 {
			dataBaseQuery = ref.queryOrderedByKey().queryStarting(atValue: values[0]).queryEnding(atValue: values[values.count - 1])
			
		}else {
			dataBaseQuery = ref.queryOrderedByKey().queryStarting(atValue: values[0])
		}
		dataBaseQuery.observe(DataEventType.value) { (dataSnapShot) in
			switch(tableName) {
			case USERCONSTANTS.DB_PATH:
				completionHandler(self.getUsers(dataSnapShot: dataSnapShot))
			case EVENTCONSTANTS.DB_PATH:
				completionHandler(self.getEvents(dataSnapShot: dataSnapShot))
			case TRANSACTIONCONSTANTS.DB_PATH:
				completionHandler(self.getTransactions(dataSnapShot: dataSnapShot))
			default:
				print("Error")
			}
		}
	}

	/*func getEventWith(eventId: String, completionHandler: @escaping (Event?, Error?) -> Void) {
		let path = EVENTCONSTANTS.DB_PATH+"/"+eventId
		let ref = Database.database().reference(withPath: path)
		ref.observeSingleEvent(of: .value, with: {(dataSnapshot) in
			if let value = dataSnapshot.value as? NSDictionary {
				let name = value["name"] as? String
				let description = value["description"] as? String ?? ""
				let date = value["date"] as? Double
				let createdBy = value["createdBy"] as? String
				var event = Event(name: name!, description: description, createdBy: createdBy!)
				event.date = date!
				completionHandler(event, nil)
			} else {
				completionHandler(nil, EventError.noSuchEvent)
			}
		}) { (error) in
			completionHandler(nil, EventError.noSuchEvent)
		}
	}
	
	func getUserWith(userId: String, completionHandler:@escaping (_ user: SplitWiserUser?,_ error: Error?) -> Void) {
		let path = USERCONSTANTS.DB_PATH+"/"+userId
		let ref = Database.database().reference(withPath: path)
		ref.observeSingleEvent(of: .value, with: {(dataSnapshot) in
			if let value = dataSnapshot.value as? NSDictionary {
				let uid = userId
				let phoneNumber = value["phoneNumber"] as? String
				let userName = value["userName"] as? String
				let email = value["email"] as? String
				var splitWiserUser = SplitWiserUser(uid: uid, phoneNumber: phoneNumber!, userName: userName!, profileImage: nil, email: email)
				if let events = value["events"] as? [String] {
					splitWiserUser.events = events
				}
				completionHandler(splitWiserUser, nil)
			} else {
				completionHandler(nil, UserError.noSuchUser)
			}
		}) { (error) in
			completionHandler(nil, UserError.noSuchUser)
		}
	}*/
	
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
			whereClause["id"] = [u.uid]
			self.fetch(whereClause: whereClause, orderedByClause: "id", tableName: USERCONSTANTS.DB_PATH, completionHandler: { (persistanceArray) in
				completionHandler((persistanceArray as! [SplitWiserUser])[0] , nil)
			})
			/*self.getUserWith(userId: u.uid, completionHandler: {(user, error) in
				completionHandler(user, error)
			})*/
		} else {
			completionHandler(nil, UserError.noSuchUser)
		}
	}
	
	func update(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		let key = persistanceConvertible.getId()
		let entry = persistanceConvertible.getColumnNamevalueDictionary()
		let updates = ["\(key)": entry] as [String : Any]
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

//MARK:
extension FirebasePersistanceManager {
	
	func getEvents(dataSnapShot:DataSnapshot) -> [PersistanceConvertible] {
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
	
	func getUsers(dataSnapShot:DataSnapshot) -> [PersistanceConvertible] {
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
	
	func getTransactions(dataSnapShot:DataSnapshot) -> [PersistanceConvertible] {
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
