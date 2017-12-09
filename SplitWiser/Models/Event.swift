//
//  Event.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/7/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct Event {
	var eventId: UUID
	var name: String
	var description: String
	var date: Date
	var createdBy: SplitWiserUser
	var transactions: [TransactionRepresentable]
}

extension Event{
    static func == (lhs : Event, rhs : Event) -> Bool{
        return (lhs.eventId == rhs.eventId)
    }
}
