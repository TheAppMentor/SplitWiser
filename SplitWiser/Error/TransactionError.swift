//
//  TransactionError.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

enum TransactionError : Error {
    case noTransactionMatchingID (transactionID : String)
    case duplicateTransaction
    case invalidEvent
    case failedToConvertTransactionToJSON(transactionID : String)
    case failedToConvertTransactionShareToJSON
}
