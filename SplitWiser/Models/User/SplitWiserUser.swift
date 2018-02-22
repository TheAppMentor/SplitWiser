//
//  SplitWiserUser.swift
//  SplitWiser
//
//  Created by Santebidanur Nagaraja, Pavan Kowshik on 12/7/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

struct SplitWiserUser {

	var uid: String
	var phoneNumber:String
	var userName:String
	var profileImage:UIImage?
	var email:String?
	var events: [String]
	private var transactionsProvider: TransactionManager
	private var eventsProvider: EventManager

	init(phoneNumber: String, userName: String, profileImage: UIImage?, email: String? = "") {
		self.uid = phoneNumber
		self.phoneNumber = phoneNumber
		self.userName = userName
		self.profileImage = profileImage
		self.email = email
		self.events = [String]()
		self.transactionsProvider = TransactionManager.shared
		self.eventsProvider = EventManager()
	}

	private func getTranscations() -> [TransactionRepresentable]? {
		return transactionsProvider.fetchTransactionsFor(userID: uid)
	}
	
	func getEvents(completionHandler: @escaping ([Event]?, Error?) -> Void) {
		eventsProvider.fetchEventsFor(user: self, completionHandler: {(events, error) in
			completionHandler(events, error)
		})
	}
	
	func getTransactionsPaidByCurrentUser() -> [TransactionRepresentable]? {
		let transactions = self.getTranscations()
		var myPaidTransactions:[TransactionRepresentable]?
		if let transactionsForUser = transactions {
			myPaidTransactions = [TransactionRepresentable]()
			for transaction in transactionsForUser {
				if transaction.paidBy == self.uid {
					myPaidTransactions?.append(transaction)
				}
			}
		}
		return myPaidTransactions
	}
}

extension SplitWiserUser : Equatable {
    
    static func == (lhs : SplitWiserUser, rhs : SplitWiserUser) -> Bool{
        return (lhs.phoneNumber == rhs.phoneNumber && lhs.userName == rhs.userName)
    }
}

extension SplitWiserUser: PersistanceConvertible {
	
	init(dataDictonary: [String : Any]) {
		self.uid = dataDictonary["id"] as! String
		self.phoneNumber = dataDictonary["phoneNumber"] as? String ?? dataDictonary["id"] as! String
		self.userName = dataDictonary["userName"] as? String ?? ""
		self.email = dataDictonary["email"] as? String ?? ""
		self.profileImage = nil
		self.events = dataDictonary["events"] as? [String] ?? []
		self.transactionsProvider = TransactionManager.shared
		self.eventsProvider = EventManager()
	}

	func getId() -> String {
		return self.uid
	}

	func getColumnNamevalueDictionary() -> [String : Any] {
		return  ["phoneNumber": self.phoneNumber,
				 "userName": self.userName,
				 "email": self.email ?? "",
				 "events": self.events as Any] as [String : Any]
	}

	func getTableName() -> String {
		return USERCONSTANTS.DB_PATH
	}


}
