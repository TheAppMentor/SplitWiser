//
//  CalculationEngine.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/11/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct CalculationEngine {
    
	func fetchTotalAmountPaidBy(event : Event, user : SplitWiserUser) throws -> Double{
		let totalAmountPaidByUser = try self.calculateTotalAmountPaidBy(event: event, user: user)
		let totalAmountRecievedByUser = try self.calculateTotalAmountOwedBy(event: event, user: user)
		return totalAmountPaidByUser - totalAmountRecievedByUser
	}
	
	func fetchTotalAmountOwedBy(event : Event, user : SplitWiserUser) throws -> Double {
		let totalAmountOwedByuser = try self.calculateTotalAmountOwedBy(event: event, user: user)
		let totalAmountPaidByuser = try self.calculateTotalAmountPaidBy(event: event, user: user)
		return totalAmountOwedByuser - totalAmountPaidByuser
	}
		
}


//MARK: All private methods here please ! :)
extension CalculationEngine {
	
	fileprivate func calculateTotalAmountPaidBy(event : Event, user : SplitWiserUser) throws -> Double{
		var totalAmountPaidByuser:Double = 0.0
		if let transacations = event.transactionsProvider.fetchAllTransactionIDForEvent(eventID: event.eventId) {
			for transaction in transacations {
                if transaction.paidBy == user.uid {
                    totalAmountPaidByuser = totalAmountPaidByuser + transaction.amount
                }
			}
		}
		return totalAmountPaidByuser
	}
	
	fileprivate func calculateTotalAmountOwedBy(event : Event, user : SplitWiserUser) throws -> Double {
		var totalAmountOwedByuser:Double = 0.0
		if let transacations = event.transactionsProvider.fetchAllTransactionIDForEvent(eventID: event.eventId) {
			for transaction in transacations {
				for splituser in transaction.paidFor {
					
					if splituser.user.uuidString == user.uid {
						//since sharepercentage is no more an optional we would presume it is set properly beforehand.
						totalAmountOwedByuser = totalAmountOwedByuser + (splituser.sharePercentage * splituser.shareAmount)
						/*if let percentage = splituser.sharePercentage {
							totalAmountOwedByuser = totalAmountOwedByuser + (percentage * splituser.shareAmount)
						} else {
							totalAmountOwedByuser = totalAmountOwedByuser + splituser.shareAmount
						}*/
					}
				}
			}
		}
		return totalAmountOwedByuser
	}
	
}
