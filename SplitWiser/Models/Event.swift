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
	var eventId: UUID?
	var name: String
	var description: String
	var date: Double
	var createdBy: User
	var transactionsProvider: TransactionManager

	init(name: String, description: String? = "", createdBy: User) {
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
