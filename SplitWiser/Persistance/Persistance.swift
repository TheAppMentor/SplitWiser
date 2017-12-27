//
//  Persistance.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/16/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

protocol Persistance {
	func insert(persistanceConvertible: PersistanceConvertible,completionHandler:@escaping (_ insertionId: String?,_ error: Error?) -> Void)
	func retrieve()
	func update()
	func delete()
}

protocol PersistanceConvertible {
	func getColumnNamevalueDictionary() -> [String : Any]
	func getTableName() -> String
}
