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
    
    var tranID : UUID
    var associatedEvent : UUID
    var tranDate : Date
    var status : TransactionStatus
    var paidBy : UUID
    var paidFor : [UserTranShare]
    var amount : Double
    var currency : TransactionCurrency
    var tranImages : [UIImage]?
    var description : String?
}

extension Transaction: PersistanceConvertible {
    func getId() -> String {
        return self.tranID.uuidString
    }
    
    func getColumnNamevalueDictionary() -> [String : Any] {
        
        let paidForString = paidFor.map({return try? $0.jsonFormat()})
        
        return  ["tranID": self.tranID.uuidString,
                 "associatedEvent": self.associatedEvent,
                 "tranDate":self.tranDate,
                 "status":self.status.hashValue,
                 "paidBy":self.paidBy,
                 "paidFor":paidForString,
                 "amount": self.amount,
                 "currency":self.currency,
                 "tranImages":self.tranImages,
                 "description":self.description] as [String : Any]
    }

    func getTableName() -> String {
        return TRANSACTIONCONSTANTS.DB_PATH
    }
    
    
}

extension Transaction : TransactionRepresentable{

    func getPaidBy() -> UUID {
        return paidBy
    }
    
    func getAssociatedEvent() -> UUID {
        return associatedEvent
    }
    
    static public func generateTransaction(date: Date?, associatedEvent: UUID, status: TransactionStatus, paidBy: UUID, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) -> Transaction? {
        
        
        return Transaction.init(tranID: UUID(), associatedEvent: associatedEvent, tranDate: date!, status: status, paidBy: paidBy, paidFor: paidFor, amount: amount, currency: currency, tranImages: transactionImages, description: transactionDescription)
    }
    
    func getTransactionID() -> UUID{
        return tranID
    }
}



