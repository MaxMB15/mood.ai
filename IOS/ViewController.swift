//
//  ViewController.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


let masterLeafNumber = 5

class ViewController: UIViewController {
    
    
    var bottomView: BottomView!
    var scrollCal: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView = BottomView(size: 320)
        
        view.addSubview(bottomView)
        view.backgroundColor = UIColor.white
        
        scrollCal = CalendarView()
        view.addSubview(scrollCal)
        
        bottomView.pv = scrollCal
        scrollCal.graphView = bottomView
        
        layout()
    }
    
    func updateColl() {
        scrollCal.reloadData()
    }
    
    func layout() {
        
        bottomView.snp.makeConstraints({ make in
            make.height.equalTo(280)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        scrollCal.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(160)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        bottomView.dataRender.postInit(dp: dataPoint)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        bottomView.dataRender.postInit(dp: masterCal.days.first!.0!)
    }
    
}
