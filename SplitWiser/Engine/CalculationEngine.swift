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
		var totalAmountPaidByuser:Double = 0.0
		if let transacations = event.transactionsProvider.fetchAllTransactionsForEvent(event: event) {
			for transaction in transacations {
				if transaction.paidBy.phoneNumber == user.phoneNumber {
					totalAmountPaidByuser = totalAmountPaidByuser + transaction.amount
				}
			}
		}
		return totalAmountPaidByuser
	}
	
	func fetchTotalAmountOwedBy(event : Event, user : SplitWiserUser) throws -> Double {
		var totalAmountOwedByuser:Double = 0.0
		if let transacations = event.transactionsProvider.fetchAllTransactionsForEvent(event: event) {
			for transaction in transacations {
				if let usersPaidFor = transaction.paidFor {
					for splituser in usersPaidFor {
						if splituser.user.phoneNumber == user.phoneNumber {
							if let percentage = splituser.sharePercentage {
							totalAmountOwedByuser = totalAmountOwedByuser + (percentage * splituser.shareAmount)
							} else {
								totalAmountOwedByuser = totalAmountOwedByuser + splituser.shareAmount
							}
						}
					}
				}
			}
		}
		return totalAmountOwedByuser
	}
		
}
