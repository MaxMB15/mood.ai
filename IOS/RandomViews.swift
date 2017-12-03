//
//  RandomViews.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit

class LeafView : UIView {
    
    var realLeaf : UIView!
    var gradient : CAGradientLayer!
    var gview : UIView!
    
    var emote : Emote?
    
    init(size: Double) {
        super.init(frame: .zero)
        
        realLeaf = UIView()
        
        gview = UIView()
        //realLeaf.addSubview(gview)
        
//        realLeaf.backgroundColor = UIColor.random(with: 0.6)
        
        
        self.addSubview(realLeaf)
        
        
        realLeaf.layer.cornerRadius = CGFloat(size/2)
        
//        gradient = CAGradientLayer()
        
        
        
        
        
        self.backgroundColor = UIColor.clear
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        self.realLeaf.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(25)
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        })
        
//        self.gview.snp.makeConstraints({ make in
//            make.size.equalToSuperview()
//            make.center.equalToSuperview()
//        })
        
//        gview.backgroundColor = UIColor.clear
//
//        gradient.startPoint = CGPoint(x: 0.5, y: 1)
//        gradient.endPoint = CGPoint(x: 0.5, y: 0)
//        gradient.colors = [UIColor.random(with: 0.5),UIColor.black]
//        gradient.locations = [0,1]
        
        //gview.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func getDataPoint(from value: Double) -> CGPoint {
        let a:CGFloat = 40
        let dp = (realLeaf.bounds.midY+(realLeaf.bounds.height-a)/2)+(realLeaf.bounds.height-a)*CGFloat(value)
        let dpContext = CGPoint(x: realLeaf.bounds.midX, y: dp)
        return realLeaf.convert(dpContext, to: self)
    }
    
    func size() {
        //gradient.frame = CGRect(x: 0.0, y: 0.0, width: realLeaf.bounds.size.width, height: realLeaf.bounds.size.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
