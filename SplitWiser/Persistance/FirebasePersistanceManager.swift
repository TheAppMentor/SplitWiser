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
    func retrieve() -> PersistanceConvertible? {
        
        return nil
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
	
	func retrieve() {
		
	}
	
	func update(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ success: Bool) -> Void) {
		let eventRef = Database.database().reference(withPath: persistanceConvertible.getTableName())
		let key = persistanceConvertible.getIdToBeModified()
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
		let node = eventRef.child(persistanceConvertible.getIdToBeModified())
		node.removeValue(completionBlock: {(error: Error?, dbRef: DatabaseReference) in
			if error != nil {
				completionHandler(false)
			} else {
				completionHandler(true)
			}
		})
	}
}
