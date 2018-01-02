//
//  EventError.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/10/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

enum EventError: Error {
	case genericError
	case creationFailed

	var localizedDescription: String {
		switch self {
		case .genericError:
			return "Generic error"
		case .creationFailed:
			return "Failed to create event"
		}
	}
}

enum UserError: Error {
	case genericError
	case noSuchUser

	var localizedDescription: String {
		switch self {
		case .genericError:
			return "Generic error"
		case .noSuchUser:
			return "No such user"
		}
	}
}
