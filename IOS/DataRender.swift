//
//  DataRender.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SceneKit


class DataRender : UIView {
    
    var leafs: [LeafView]!
    var lineShape: CAShapeLayer!
    var lineView : UIView!
    
    init(leafNumber: Int, size: Double) {
        super.init(frame: .zero)
        
        let jumpDeg = Double.pi*Double(2)/Double(leafNumber)
        
        leafs = []
        
        for i in 0..<leafNumber {
            let aLeaf = LeafView(size: size)
            leafs.append(aLeaf)
            aLeaf.transform = CGAffineTransform(rotationAngle: CGFloat(-Double(i)*(jumpDeg)))
            self.addSubview(aLeaf)
            aLeaf.snp.makeConstraints({make in
                make.width.equalTo(size/3)
                make.height.equalTo(size*2)
                make.center.equalToSuperview()
            })
        }
        
        var gradientView = IgnoreImageView(image: #imageLiteral(resourceName: "fauxGradient"))
//        gradientView.alpha = 0.9
        self.addSubview(gradientView)
        
        gradientView.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        })
        
        lineView = UIView()
        self.addSubview(lineView)
        lineView.snp.makeConstraints({make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        })
        lineView.backgroundColor = UIColor.clear
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        for leaf in leafs {
            leaf.addGestureRecognizer(tap)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func postInit(dp: DataPoint) {
        var dps : [CGPoint] = []
        
        for (i,e) in masterState.scrollPos.enumerated() {
            let p = leafs[i].convert(leafs[i].getDataPoint(from: dp.get(e)), to: self)
            leafs[i].realLeaf.backgroundColor = emotes(e).withAlphaComponent(0.7)
            leafs[i].emote = e
            dps.append(p)
        }
        lineView.layer.sublayers?.removeAll()
        lineShape = lineView.addLine(with: dps)
        linestuff()
    }
    
    func postInit() {
        
        let dp = masterCal.getDataOfDay(at: masterCal.currentDate)
        var dps : [CGPoint] = []
        
        for (i,e) in masterState.scrollPos.enumerated() {
            let p = leafs[i].convert(leafs[i].getDataPoint(from: dp.get(e)), to: self)
            dps.append(p)
        }
        
        lineView.layer.sublayers?.removeAll()
        lineShape = lineView.addLine(with: dps)
        
        linestuff()
    }
    
    func linestuff() {
        lineShape.fillColor = UIColor.clear.cgColor
        lineShape.strokeColor = UIColor.black.cgColor
        lineShape.lineWidth = 2
        lineView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/Double(leafs.count)))
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
//        for l in leafs {
//            if l.realLeaf.bounds.contains(sender.location(in: l)) {
//                print("nice")
//            }
//        }
    }
    
}
