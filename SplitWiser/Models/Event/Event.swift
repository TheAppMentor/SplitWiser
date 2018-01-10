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
	var eventId: String
	var name: String
	var description: String
	var date: Double
	var createdBy: String
	var members: [String]
	var transactionsProvider: TransactionManager

	init(name: String, description: String? = "", createdBy: String, members: [String]? = []) {
        self.eventId = UUID().uuidString
		self.name = name
		self.description = description ?? ""
		self.date = Date().timeIntervalSince1970
		self.createdBy = createdBy
		self.members = members!
		self.transactionsProvider = TransactionManager.shared
	}
}

extension Event {
    static func == (lhs : Event, rhs : Event) -> Bool {
        return (lhs.eventId == rhs.eventId)
    }
}

extension Event: PersistanceConvertible {
	
	init(dataDictonary: [String : Any]) {
		self.eventId = dataDictonary["id"] as! String
		self.name = dataDictonary["name"] as! String
		self.description = dataDictonary["description"] as! String
		self.date = Date().timeIntervalSince1970
		self.createdBy = dataDictonary["createdBy"] as! String
		self.transactionsProvider = TransactionManager.shared
		self.members = dataDictonary["members"] as! [String]
	}
	
	func getId() -> String {
		return self.eventId
	}
	
	func getColumnNamevalueDictionary() -> [String : Any] {
		return  ["name": self.name,
					 "description": self.description,
					 "date": self.date,
					 "createdBy": self.createdBy,
					 "members": self.members as Any] as [String : Any]
	}
	
	func getTableName() -> String {
		return EVENTCONSTANTS.DB_PATH
	}
	
	
}

