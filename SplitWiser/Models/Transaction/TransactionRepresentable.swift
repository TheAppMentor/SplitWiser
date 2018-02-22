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
    
    var tranID : String {get}
    var associatedEvent : String {get set}
    var tranDate : Double {get}
    var status : TransactionStatus {get set}
    var paidBy : String {get}
    var paidFor : [UserTranShare] {get}
    var amount : Double {get}
    var currency : TransactionCurrency {get}
    var tranImages : [UIImage]? {get}
    var description : String? {get}
    
    static func generateTransaction(date : Double?, associatedEvent : String, status : TransactionStatus, paidBy : String, paidFor : [UserTranShare], amount : Double, currency : TransactionCurrency, transactionImages : [UIImage]?, transactionDescription : String) -> Self?
}
