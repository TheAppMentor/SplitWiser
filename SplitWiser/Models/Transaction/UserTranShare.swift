//
//  UserTranShare.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

protocol JSONRepresentable{
    func jsonFormat() throws -> String
}

protocol JSONInitable{
    init(json : [String:Any?]) throws
}

struct UserTranShare {
    var user : UUID
    var sharePercentage : Double = 0.0
    var shareAmount : Double
}

extension UserTranShare : JSONRepresentable{
    func jsonFormat() throws -> String{
        var tempDict = [String:Any]()
        tempDict["user"] = self.user
        tempDict["sharePercentage"] = self.sharePercentage
        tempDict["shareAmount"] = self.shareAmount
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: tempDict, options: .prettyPrinted)
            
            if let jsonString = String.init(data: jsonData, encoding: .utf8){
                return jsonString
            }
            
        }catch{
            print("Error Converting UserTranShare to JSON")
            throw TransactionError.failedToConvertTransactionShareToJSON
        }
        
        throw TransactionError.failedToConvertTransactionShareToJSON
    }
    
}


extension UserTranShare : JSONInitable{
    init(json jsonDict: [String:Any?]) throws {
        guard let user = jsonDict["user"] as? UUID else {throw TransactionError.failedToConvertTransactionShareToJSON}
        guard let sharePercentage = jsonDict["sharePercentage"] as? Double else {throw TransactionError.failedToConvertTransactionShareToJSON}
        guard let shareAmount = jsonDict["shareAmount"] as? Double else {throw TransactionError.failedToConvertTransactionShareToJSON}

        self.user = user
        self.sharePercentage = sharePercentage
        self.shareAmount = shareAmount
    }
}
