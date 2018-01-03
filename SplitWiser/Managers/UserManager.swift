//
//  UserManager.swift
//  SplitWiser
//
//  Created by Santebidanur Nagaraja, Pavan Kowshik on 12/9/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct UserManager {

	let persistanceManager: Persistance = PersistanceFactory.getPersistanceManager()

	func currentLoggedInUser(completionHandler: @escaping (SplitWiserUser?, Error?) -> Void) {
		persistanceManager.getCurrentLoggedInUser(completionHandler: {(user, error) in
			completionHandler(user,error)
		})
	}

	func getUserWith(userID: String, completionHandler: @escaping (SplitWiserUser?, Error?) -> Void) {
		var whereClause = [String:[String]]()
		whereClause["id"] = [userID]
		persistanceManager.fetch(whereClause: whereClause, orderedByClause: "id", tableName: USERCONSTANTS.DB_PATH, completionHandler: { (persistanceArray) in
			completionHandler((persistanceArray as! [SplitWiserUser])[0] , nil)
		})
		/*persistanceManager.getUserWith(userId: userID, completionHandler: {(user, error) in
			completionHandler(user,error)
		})*/
    }
    
	func registerUser(userID: String, userName: String, email: String, phoneNumber: String? = "", completionHandler: @escaping (Bool) -> Void) {
		let splitWiserUser = SplitWiserUser(uid: userID, phoneNumber: phoneNumber!, userName: userName, profileImage: nil, email: email)
		persistanceManager.insert(persistanceConvertible: splitWiserUser, autoGenerateKey: false) { (insertionId, error) in
			if let insertionError = error {
				print(insertionError.localizedDescription)
				completionHandler(false)
			} else {
				completionHandler(true)
			}
		}
	}
}
