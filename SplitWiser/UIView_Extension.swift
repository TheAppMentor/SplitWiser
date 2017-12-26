//
//  UIView_Extension.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<A: UIView> (nibName name: String, bundle: Bundle? = nil) -> A? {
        let bundle = bundle ?? Bundle.main
        let nibViews = bundle.loadNibNamed(name, owner: self, options: nil)
        return nibViews?.first as? A
    }
    
    class func fromNib<T: UIView>() -> T? {
        return fromNib(nibName: String(describing: T.self), bundle: nil)
    }
}
