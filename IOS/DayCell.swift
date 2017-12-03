//
//  DayCell.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DayCell : UICollectionViewCell {
    
    var dp :DataPoint?
    
    var coloredView : IgnoreTouchView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.coloredView = IgnoreTouchView()
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(coloredView)
        coloredView.snp.makeConstraints({make in
            make.size.equalToSuperview().inset(2)
            make.center.equalToSuperview()
        })
        self.layer.cornerRadius = CGFloat(2)
    }
    
    func setWith(dp: DataPoint) {
        coloredView.layer.borderColor = UIColor.clear.cgColor
        coloredView.layer.borderWidth = 0
        self.dp = dp
    }
    
    func color(for emot: Emote) {
        coloredView.backgroundColor = emotes(emot).withAlphaComponent(CGFloat((dp?.get(emot))!))
        if backgroundColor?.cgColor.alpha == 0 {
            coloredView.layer.borderColor = UIColor.black.withAlphaComponent(CGFloat(0.2)).cgColor
            coloredView.layer.borderWidth = 1.0
        }
    }
    
    func select(to state: Bool) {
        if state {
            coloredView.layer.cornerRadius = 10
        } else {
            coloredView.layer.cornerRadius = 2
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
