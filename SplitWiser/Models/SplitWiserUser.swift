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
	
	var phoneNumber:String
	var userName:String
	var profileImage:UIImage?
	var email:String?
	var transactionsProvider: TransactionHandler
	var eventsProvider: EventManager
	
	func getTranscations() -> [TransactionRepresentable]? {
		return transactionsProvider.fetchTransactionsFor(user: self)
	}
	
	func getEvents() -> [Event]? {
		return eventsProvider.getEventsFor(user: self)
	}
}
