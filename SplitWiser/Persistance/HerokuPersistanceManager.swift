//
//  HerokuPersistanceManager.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/29/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct HerokuPersistanceManager: Persistance {
    func retrieve() -> PersistanceConvertible? {
        return nil
    }
    
	func insert(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (String?, Error?) -> Void) {

	}


	func update() {

	}

	func delete(persistanceConvertible: PersistanceConvertible, completionHandler: @escaping (Bool) -> Void) {

	}
}
