//
//  TransactionRepresentable.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

protocol TransactionRepresentable {
    
    var tranID : UUID {get}
    var associatedEvent : UUID {get set}
    var tranDate : Date {get}
    var status : TransactionStatus {get set}
    var paidBy : UUID {get}
    var paidFor : [UserTranShare] {get}
    var amount : Double {get}
    var currency : TransactionCurrency {get}
    var tranImages : [UIImage]? {get}
    var description : String? {get}
    
    static func generateTransaction(date : Date?, associatedEvent : UUID, status : TransactionStatus, paidBy : UUID, paidFor : [UserTranShare], amount : Double, currency : TransactionCurrency, transactionImages : [UIImage]?, transactionDescription : String) -> Self?
}
