//
//  Event.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/7/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

class Event {
	
	var eventId: String!
	var name: String!
	var description: String!
	var date: Date!
	var amount: Int!
	var paidBy: [User]!
	var participants: [User]!
}
