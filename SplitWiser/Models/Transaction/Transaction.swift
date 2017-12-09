//
//  Transaction.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit


private struct Transaction : Equatable {
    
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

    //private init() {}

    func generateTransaction(date: Date?, associatedEvent: Event, status: TransactionStatus, paidBy: SplitWiserUser, paidFor: [UserTranShare], amount: Double, currency: TransactionCurrency, transactionImages: [UIImage]?, transactionDescription: String) -> Transaction? {
                
        
        return Transaction.init(tranID: UUID(), associatedEvent: associatedEvent, tranDate: date!, status: status, paidBy: paidBy, paidFor: paidFor, amount: amount, currency: currency, tranImages: transactionImages, description: transactionDescription)
        }
    
    func getTransactionID() -> UUID{
        return tranID
    }
}


