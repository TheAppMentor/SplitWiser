//
//  ParticiapntListView.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit


protocol ParticipantRepresentable {
    var profileImage : UIImage? {get}
    var shortDisplayName : String {get}
}


class ParticipantListView: UIView {
    
    @IBOutlet weak var collectionViewParticipants: UICollectionView!
    
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
    
    override func awakeFromNib() {
        collectionViewParticipants.register(ParticipantCell.self, forCellWithReuseIdentifier: "participantCell")
    }
    
    func setupView() {
        let bundle = Bundle.init(for: type(of: self))
        let ourNib = UINib(nibName: "ParticipantListView", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        self.addSubview(theView)
    }

    override func draw(_ rect: CGRect) {

        print("ParticiapntListView -> Got Called");
    }
    
    
    func addParticipant(participant : ParticipantRepresentable) -> Bool {
        
        return false
    }
    
    func removeParticipant(participant : ParticipantRepresentable) -> Bool {
        
        return false
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}


extension ParticipantListView : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let theCell = collectionViewParticipants.dequeueReusableCell(withReuseIdentifier: "participantCell", for: indexPath)
        return theCell
    }
}
