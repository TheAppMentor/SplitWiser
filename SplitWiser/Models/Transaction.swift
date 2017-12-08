//
//  Transaction.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

enum TransactionStatus {
    case pending
    case complete
}

enum TransactionCurrency {
    case Rupee
    case Dollar
    case Euro
}

struct Transaction {
    var tranID : UUID
    var tranDate : Date
    var status : TransactionStatus
    var paidBy : User
    var paidFor : [User]? // Need something to split by diff % for each user.
    var amount : Double
    var currency : TransactionCurrency
    var tranImages : [UIImage]?
    var description : String?
}
