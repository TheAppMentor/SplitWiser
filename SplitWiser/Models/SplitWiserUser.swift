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
	var transactionsProvider: TransactionManager
	var eventsProvider: EventManager
	
	func getTranscations() -> [TransactionRepresentable]? {
		return transactionsProvider.fetchTransactionsFor(user: self)
	}
	
	func getEvents() -> [Event]? {
		return eventsProvider.getEventsFor(user: self)
	}
}

extension SplitWiserUser : Equatable {
    
    static func == (lhs : SplitWiserUser, rhs : SplitWiserUser) -> Bool{
        return (lhs.phoneNumber == rhs.phoneNumber && lhs.userName == rhs.userName)
    }
}
