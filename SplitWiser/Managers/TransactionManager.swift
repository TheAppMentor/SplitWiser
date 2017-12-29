//
//  TransactionHandler.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

struct TransactionManager : TransactionDelegate {
	
    static let shared = TransactionManager()
	
	private let calculationEngine : CalculationEngine
    
    private var transactionStore = [TransactionRepresentable]()
    
    private init(){
		calculationEngine = CalculationEngine()
	}
    
    mutating func addTransaction(date: Date?, associatedEvent: UUID, status: TransactionStatus, paidBy: UUID, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) throws -> TransactionRepresentable? {
        
        if let tran =  Transaction.generateTransaction(date: date, associatedEvent: associatedEvent, status: status, paidBy: paidBy, paidFor: paidFor, amount: amount, currency: currency, transactionImages: transactionImages, transactionDescription: transactionDescription){
            transactionStore.append(tran)
            return tran
        }

        return nil
    }
    
    func fetchTransaction(tranID : UUID) throws -> TransactionRepresentable?{
        
        // No Transaction found.
        guard transactionStore.isEmpty == false else {throw TransactionError.noTransactionMatchingID(transactionID: tranID)}
        
        let fetchedTrans = transactionStore.filter({return ($0.tranID == tranID)})

        // No Matching Transaction found.
        guard fetchedTrans.isEmpty == false else {throw TransactionError.noTransactionMatchingID(transactionID: tranID)}
        guard fetchedTrans.count == 1 else {throw TransactionError.duplicateTransaction}
        
        return fetchedTrans.first ?? nil
    }
    
    
    func fetchTransactionsFor(userID: String) -> [TransactionRepresentable]? {
        if let theUser = UserManager().getUserWith(userID: userID){
            assertionFailure("Prashanth Implement this shit.")
        }
        
        return nil
    }
    
    func fetchAllTransactionsFor(eventID: String, userID: String) throws -> [TransactionRepresentable]? {
        if let theUser = UserManager().getUserWith(userID: userID){
            if let theEvent = EventManager().getDetailsOfEvent(id: eventID){
                assertionFailure("Prashanth Implment this shit man.")
            }
        }
        return nil

    }
    
    func fetchTotalAmountPaidBy(eventID: String, userID: String) throws -> Double? {
        if let theUser = UserManager().getUserWith(userID: userID){
            if let theEvent = EventManager().getDetailsOfEvent(id: eventID){
                return try calculationEngine.fetchTotalAmountPaidBy(event: theEvent, user: theUser)
            }
        }
        return nil
    }
    
    func fetchTotalAmountOwed(eventID: String, userID: String) throws -> Double? {

        if let theUser = UserManager().getUserWith(userID: userID){
            if let theEvent = EventManager().getDetailsOfEvent(id: eventID){
                if let theAmount = try? calculationEngine.fetchTotalAmountOwedBy(event: theEvent, user: theUser){
                    return theAmount
                }
            }
        }
        return nil

        
    }

    
    
    
    
    func fetchDetailsForTransactions(transactions : [UUID]) throws -> [TransactionRepresentable]? {
//        do{
//            for eachTransaction in transactions{
//                try fetchTransaction(tranID: eachTransaction)
//            }
//
//        }
        
        return nil
    }
    
    func fetchAllTransactionIDForEvent(eventID: String) -> [TransactionRepresentable]? {
        return nil
    }
    
    
    func fetchTotalAmountPaidBy(event: Event, user: UUID) throws -> Double? {
        
        return nil
    }

    
    func fetchTotalAmountOwed(event: Event, user: UUID) throws -> Double? {
        if let theUser = UserManager().getUserWith(userID: user.uuidString){
            return try calculationEngine.fetchTotalAmountOwedBy(event:event,user:theUser)
        }
        return nil
    }
    
    func fetchAllTransactionsForEvent(eventID: String) -> [TransactionRepresentable]? {
        
        //TODO: Prashanth Re-look at this .
        let allTrans = transactionStore.filter({$0.associatedEvent.uuidString == eventID})
        return allTrans

    }


    
}
