//
//  PersistanceFactory.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/29/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

enum DBTYPE {
	case firebase
	case heroku
}


struct PersistanceFactory {

	private static let dbType = DBTYPE.firebase

	static func getPersistanceManager() -> Persistance {

		switch dbType {
		case .firebase:
			return FirebasePersistanceManager()
		case .heroku:
			return HerokuPersistanceManager()
		}
	}
}
