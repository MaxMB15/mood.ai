//
//  CalendarView.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CalendarView : UICollectionView {
    
    var graphView: BottomView!
    
    convenience init() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 25 , height: 25)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset.left = 20
        layout.sectionInset.right = 20
        layout.scrollDirection = .horizontal
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        //self.contentOffset = CGPoint(x:20, y:0)
        self.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.03529411765, blue: 0.03529411765, alpha: 0)
        self.showsHorizontalScrollIndicator = false
        self.isUserInteractionEnabled = true
        self.contentInset.top = 10
        self.contentInset.bottom = 10
        self.zoomScale = 2.0
        self.allowsMultipleSelection = false
        
        self.register(DayCell.self, forCellWithReuseIdentifier: "stack")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let c = cellForItem(at: indexPath) as? DayCell {
            c.select(to: true)
            masterCal.currentDate = (indexPath.section,indexPath.row)
            graphView.dataRender.postInit(dp: masterCal.getDataOfDay(at: masterCal.currentDate))
        }
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let c = cellForItem(at: indexPath) as? DayCell {
            c.select(to: false)
        }
    }
}
    
extension CalendarView : UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 || section == 2 {
                return 30
            }
            return 31
        }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 4
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stack", for: indexPath) as! DayCell
//            print(masterCal.getDataOfDay(at: (indexPath.section, indexPath.row)))
            cell.setWith(dp: masterCal.getDataOfDay(at: (indexPath.section, indexPath.row)))

            cell.color(for: masterState.scrollPos[0])
            if masterCal.currentDate == (indexPath.section,indexPath.row) {
                cell.select(to: true)
            } else {
                cell.select(to: false)
            }
            return cell
        }
    
    
}
