//
//  BottomView.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SceneKit

class BottomView : UIView {
    
    var dataRender: DataRender!
    
    var pv: CalendarView!
    
    var currentAngle = CGFloat(0)
    let rotation = CGFloat(2*Double.pi/5)
    
    var labels: [UILabel]!
    
    var updated: Bool!
    
    var processButton : UIButton!
    
    init(size: Double) {
        
        super.init(frame: .zero)
        labels = []
        updated = false
        self.backgroundColor = UIColor.white
        self.clipsToBounds = false
        
        dataRender = DataRender(leafNumber: masterLeafNumber, size : 150)
        addSubview(dataRender)
        
        for i in 0..<masterLeafNumber {
            let lb = UILabel()
            if i == 0 {
                lb.customSelected()
            } else {
                lb.customActive()
            }
            self.addSubview(lb)
            labels.append(lb)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(tap)

        
        
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        
        dataRender.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        })
        
        
        labels[0].snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(-20)
            make.centerX.equalToSuperview()
        })
        labels[1].snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(40)
        })
        labels[2].snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(80)
        })
        labels[3].snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(80)
        })
        labels[4].snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(40)
        })
        
        updateLabels()
    }
    
    @objc func tap(_ sender : UITapGestureRecognizer) {
//        print(sender.location(in: self))
        
        if sender.location(in: self).x > self.bounds.midX{
            tapRight()
        } else {
            tapLeft()
        }
        
    }
    
    @objc func tapLeft() {
        turnLabel(to: false)
        currentAngle = currentAngle - rotation
        masterState.scroll(to: true)
        
//        csvParser()
        
        UIView.animate(withDuration:0.5, animations: {
            self.dataRender.transform = CGAffineTransform(rotationAngle:self.currentAngle)
        }, completion:{ _ in
            self.updateLabels()
            self.pv.reloadData()
            self.turnLabel(to: true)
        })
    }
    
    
    
    @objc func tapRight() {
        
//        helloHTTP()
        
        turnLabel(to: false)
        currentAngle = currentAngle + rotation
        masterState.scroll(to: false)
        
        UIView.animate(withDuration:0.5, animations: {
            self.dataRender.transform = CGAffineTransform(rotationAngle:self.currentAngle )
        }, completion:{ _ in
            
            
            self.pv.reloadData()
            self.updateLabels()
            self.turnLabel(to: true)
        })
    }
    
    func turnLabel(to state: Bool) {
        for l in self.labels {
            if state {
                UIView.animate(withDuration: 0.2, animations: {
                    l.layer.opacity = 1
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    l.layer.opacity = 0
                })
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !updated {
            dataRender.postInit(dp: masterCal.getDataOfCurrentDay() )
            updated = true
        } else {
            super.touchesBegan(touches, with: event)
            
        }
    }
    
    
    func updateLabels() {
        for (i,l) in labels.enumerated() {
            l.text = masterState.scrollPos[i].rawValue
        }
    }
    
    
}
