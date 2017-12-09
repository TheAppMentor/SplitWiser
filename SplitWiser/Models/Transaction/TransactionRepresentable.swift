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
    
    func generateTransaction(date : Date?, associatedEvent : Event, status : TransactionStatus, paidBy : SplitWiserUser, paidFor : [UserTranShare], amount : Double, currency : TransactionCurrency, transactionImages : [UIImage]?, transactionDescription : String) -> Self?
    
    func getTransactionID() -> UUID
    func getPaidBy() -> SplitWiserUser
    func getAssociatedEvent() -> Event
}
