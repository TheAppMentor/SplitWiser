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
	var transactionsProvider: TransactionManager
	var eventsProvider: EventManager
	
	private func getTranscations() -> [TransactionRepresentable]? {
		return transactionsProvider.fetchTransactionsFor(userID: uid)
	}
	
	func getEvents() -> [Event]? {
		eventsProvider.fetchEventsFor(user: self, completionHandler: {(events, error) in

		})
		return nil
	}
	
	func getTransactionsPaidByCurrentUser() -> [TransactionRepresentable]? {
		let transactions = self.getTranscations()
		var myPaidTransactions:[TransactionRepresentable]?
		if let transactionsForUser = transactions {
			myPaidTransactions = [TransactionRepresentable]()
			for transaction in transactionsForUser {
				if transaction.paidBy.uuidString == self.uid {
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
