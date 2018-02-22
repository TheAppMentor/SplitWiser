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
    
	func fetchTransactionsFor(userID : String) ->[TransactionRepresentable]?
    func fetchAllTransactionsForEvent(eventID : String) -> [TransactionRepresentable]?
    func fetchAllTransactionsFor(eventID : String, userID : String) throws -> [TransactionRepresentable]?

    func fetchTotalAmountPaidBy(eventID : String, userID : String) throws -> Double?
    func fetchTotalAmountOwed(eventID : String, userID : String) throws -> Double?

    mutating func addTransaction(date : Double?,
                        associatedEvent : String,
                        status : TransactionStatus,
                        paidBy : String,
                        paidFor : [UserTranShare],
                        amount : Double,
                        currency : TransactionCurrency,
                        transactionImages : [UIImage]?,
                        transactionDescription : String) throws -> TransactionRepresentable?
}

extension TransactionDelegate {
    
/*
    func fetchTransactionsFor(user : SplitWiserUser) ->[TransactionRepresentable]? {
		//transactions for a particular user irrespective of events
		return nil
	}
    
    func fetchAllTransactionsFor(event : Event, user : SplitWiserUser) throws -> [TransactionRepresentable]?{
        guard let allTrans = fetchAllTransactionsForEvent(eventID: event) else {
            throw TransactionError.invalidEvent
        }
        
        let allTransForUser = allTrans.filter({return $0.paidBy.uuidString == user.uid})
        return allTransForUser
    }
    
    func fetchTotalAmountPaidFor(event : Event, user : SplitWiserUser) -> Double?{
        
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
