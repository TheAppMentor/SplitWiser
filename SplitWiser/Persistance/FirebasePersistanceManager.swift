//
//  FirebasePersistanceManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/16/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FirebasePersistanceManager: Persistance {

	func createUser(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (String?, Error?) -> Void) {
		let path = USERCONSTANTS.DB_PATH
		let ref = Database.database().reference(withPath: path)
		let entry = persistanceConvertible.getColumnNamevalueDictionary()
		let updates = ["\(persistanceConvertible.getId())": entry] as [String : Any]
		ref.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			completionHandler(persistanceConvertible.getId(),error)
		})
	}

	
	func insert(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ insertionId: String?,_ error: Error?) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		let key = eventRef.childByAutoId().key
		let entry = persistanceConvertible.getColumnNamevalueDictionary()
		let updates = ["\(key)": entry] as [String : Any]
		eventRef.updateChildValues(updates, withCompletionBlock: {(error: Error?, dbRef: DatabaseReference) in
			completionHandler(key,error)
		})
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
			print(error.localizedDescription)
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
