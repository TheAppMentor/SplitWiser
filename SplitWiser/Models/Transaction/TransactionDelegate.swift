//
//  TransactionDelegate.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/9/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

// Reshma, Pavan :
// For any operation related to transaction, please add your required methods here..
// I will add the implementation.

protocol TransactionDelegate {
    
    func someSampleMethod()
	func fetchTransactionsFor(user : SplitWiserUser) ->[TransactionRepresentable]?
    func fetchAllTransactionsForEvent(event : Event) -> [TransactionRepresentable]?
    func fetchAllTransactionsFor(event : Event, user : SplitWiserUser) throws -> [TransactionRepresentable]?

    func fetchTotalAmountPaidBy(event : Event, user : SplitWiserUser) throws -> Double?
    func fetchTotalAmountOwed(event : Event, user : SplitWiserUser) throws -> Double?

    mutating func addTransaction(date : Date?,
                        associatedEvent : Event,
                        status : TransactionStatus,
                        paidBy : SplitWiserUser,
                        paidFor : [UserTranShare],
                        amount : Double,
                        currency : TransactionCurrency,
                        transactionImages : [UIImage]?,
                        transactionDescription : String) throws -> TransactionRepresentable?
}


extension TransactionDelegate {
    
    func someSampleMethod(){
        // Empty Implementation, Prashanth will implement.
    }
	
	func fetchTransactionsFor(user : SplitWiserUser) ->[TransactionRepresentable]? {
		//transactions for a particular user irrespective of events
		return nil
	}
    
    func fetchAllTransactionsFor(event : Event, user : SplitWiserUser) throws -> [TransactionRepresentable]?{
        guard let allTrans = fetchAllTransactionsForEvent(event: event) else {
            throw TransactionError.invalidEvent
        }
        
        let allTransForUser = allTrans.filter({return $0.paidBy == user})
        return allTransForUser
    }
    
   /* func fetchTotalAmountPaidFor(event : Event, user : SplitWiserUser) -> Double?{
        
        return nil
    }
    
    func fetchTotalAmountPaidBy(event: Event, user: SplitWiserUser) throws -> Double? {
        do {
            guard let allTransForUser = try fetchAllTransactionsFor(event: event, user: user) else {
                return nil
            }

            return allTransForUser.map({$0.amount}).reduce(0, +)
            
        } catch TransactionError.invalidEvent{
            throw TransactionError.invalidEvent
        }
        
    }
    
    func fetchTotalAmountOwed(event: Event, user: SplitWiserUser) -> Double? {
        return nil
    }*/
    
}
