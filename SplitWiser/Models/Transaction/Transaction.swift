//
//  Transaction.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit


struct Transaction : Equatable {
    
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.tranID == rhs.tranID
    }
    
    var tranID : String
    var associatedEvent : String
    var tranDate : Double
    var status : TransactionStatus
    var paidBy : String
    var paidFor : [UserTranShare]
    var amount : Double
    var currency : TransactionCurrency
    var tranImages : [UIImage]?
    var description : String?

	init(date: Double? = nil, associatedEvent: String, status: TransactionStatus, paidBy: String, paidFor: [UserTranShare], amount: Double, currency : TransactionCurrency) {
		self.associatedEvent = associatedEvent
		self.status = status
		self.paidBy = paidBy
		self.paidFor = paidFor
		self.amount = amount
		self.currency = currency
		self.tranID = UUID().uuidString
		if let date = date {
			self.tranDate = date
		} else {
			self.tranDate = Date().timeIntervalSince1970
		}
	}
}

extension Transaction: PersistanceConvertible {
	
	init(dataDictonary: [String : Any]) {
		//@Prashanth please fill this up :D
		self.tranID = UUID().uuidString
		self.associatedEvent = UUID().uuidString
		self.tranDate = Date().timeIntervalSince1970
		self.status = .complete
		self.paidBy = UUID().uuidString
		self.paidFor = [UserTranShare]()
		self.amount = 0.0
		self.currency = .Dollar
		self.tranImages = nil
		self.description = nil
	}
	
    func getId() -> String {
        return self.tranID
    }
    
    func getColumnNamevalueDictionary() -> [String : Any] {
        
        let paidForString = paidFor.map({return try? $0.jsonFormat()})
        
        return  ["tranID": self.tranID,
                 "associatedEvent": self.associatedEvent,
                 "tranDate":self.tranDate,
                 "status":self.status.hashValue,
                 "paidBy":self.paidBy,
                 "paidFor":paidForString,
                 "amount": self.amount,
                 "currency":self.currency,
				 "tranImages":self.tranImages as Any,
				 "description":self.description as Any] as [String : Any]
    }

    func getTableName() -> String {
        return TRANSACTIONCONSTANTS.DB_PATH
    }
    
    
}

extension Transaction : TransactionRepresentable{

    func getPaidBy() -> String {
        return paidBy
    }
    
    func getAssociatedEvent() -> String {
        return associatedEvent
    }
    
    static public func generateTransaction(date: Double?, associatedEvent: String, status: TransactionStatus, paidBy: String, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) -> Transaction? {

		return Transaction(date: date, associatedEvent: associatedEvent, status: status, paidBy: paidBy, paidFor: paidFor, amount: amount, currency: currency)
    }
    
    func getTransactionID() -> String{
        return tranID
    }
}



