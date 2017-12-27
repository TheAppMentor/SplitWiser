//
//  Event.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/7/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Event {
	var eventId: String? //What if I make this a hash of userEmailId+eventName+timeStamp?
	var name: String
	var description: String
	var date: Double
	var createdBy: SplitWiserUser
	var transactionsProvider: TransactionManager

	init(name: String, description: String? = "", createdBy: SplitWiserUser) {
		self.name = name
		self.description = description!
		self.date = Date().timeIntervalSince1970
		self.createdBy = createdBy
		self.transactionsProvider = TransactionManager.shared
	}
}

extension Event {
    static func == (lhs : Event, rhs : Event) -> Bool {
        return (lhs.eventId == rhs.eventId)
    }
}

extension Event: PersistanceConvertible {
	func getColumnNamevalueDictionary() -> [String : Any] {
		return  ["name": self.name,
					 "description": self.description,
					 "date": self.date,
					 "createdBy": self.createdBy.uid as Any] as [String : Any]
	}
	
	func getTableName() -> String {
		return EVENTCONSTANTS.DB_PATH
	}
	
	
}

