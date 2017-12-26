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
    
    mutating func addTransaction(date: Date?, associatedEvent: Event, status: TransactionStatus, paidBy: SplitWiserUser, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) throws -> TransactionRepresentable? {
                
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
    
    func fetchDetailsForTransactions(transactions : [UUID]) throws -> [TransactionRepresentable]? {
//        do{
//            for eachTransaction in transactions{
//                try fetchTransaction(tranID: eachTransaction)
//            }
//
//        }
        
        return nil
    }
    
    func fetchAllTransactionsForEvent(event: Event) -> [TransactionRepresentable]? {
        let allTrans = transactionStore.filter({$0.associatedEvent == event})
        return allTrans
    }
	
	func fetchTotalAmountPaidBy(event: Event, user: SplitWiserUser) throws -> Double? {
		return try calculationEngine.fetchTotalAmountOwedBy(event:event,user:user)
	}
	
	func fetchTotalAmountOwed(event: Event, user: SplitWiserUser) throws -> Double? {
		return try calculationEngine.fetchTotalAmountOwedBy(event:event,user:user)
	}
    
}




fileprivate struct Transaction : Equatable {
    
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.tranID == rhs.tranID
    }
    
    var tranID : UUID
    var associatedEvent : Event
    var tranDate : Date
    var status : TransactionStatus
    var paidBy : SplitWiserUser
    var paidFor : [UserTranShare]?
    var amount : Double
    var currency : TransactionCurrency
    var tranImages : [UIImage]?
    var description : String?
}

extension Transaction : TransactionRepresentable{
    func getPaidBy() -> SplitWiserUser {
        return paidBy
    }
    
    func getAssociatedEvent() -> Event {
        return associatedEvent
    }
    
    static public func generateTransaction(date: Date?, associatedEvent: Event, status: TransactionStatus, paidBy: SplitWiserUser, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) -> Transaction? {
        
        
        return Transaction.init(tranID: UUID(), associatedEvent: associatedEvent, tranDate: date!, status: status, paidBy: paidBy, paidFor: paidFor, amount: amount, currency: currency, tranImages: transactionImages, description: transactionDescription)
    }
    
    func getTransactionID() -> UUID{
        return tranID
    }
}

