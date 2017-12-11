//
//  Event.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/7/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct Event {
	var eventId: UUID?
	var name: String
	var description: String
	var date: Double
	//var createdBy: SplitWiserUser
	//var transactions: [TransactionRepresentable]?

	init(name: String, description: String? = "") {
		self.name = name
		self.description = description!
		self.date = Date().timeIntervalSince1970
		//self.createdBy = createdBy
	}
}

extension Event {
    static func == (lhs : Event, rhs : Event) -> Bool {
        return (lhs.eventId == rhs.eventId)
    }
}
