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

	func getUserWith(userID: String, completionHandler: @escaping (SplitWiserUser?, Error?) -> Void) {
		persistanceManager.getUserWith(userId: userID, completionHandler: {(user, error) in
			completionHandler(user,error)
		})
    }
    
	func registerUser(userID: String, userName: String, email: String, phoneNumber: String? = "", completionHandler: @escaping (Bool) -> Void) {
		let splitWiserUser = SplitWiserUser(uid: userID, phoneNumber: phoneNumber!, userName: userName, profileImage: nil, email: email)
		persistanceManager.createUser(persistanceConvertible: splitWiserUser, completionHandler: {(insertionId, error) in
			if error == nil {
				completionHandler(true)
			}
		})
	}
}
