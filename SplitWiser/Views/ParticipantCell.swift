//
//  ParticipantCell.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class ParticipantCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        let bundle = Bundle.init(for: type(of: self))
        let ourNib = UINib(nibName: "ParticipantCell", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        self.addSubview(theView)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
