//
//  Singleton.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit


enum Pos : String {
    case top = "top"
    case left = "left"
    case right = "right"
}

struct DataPoint {
    
    var joy: Double = 0
    var sadness: Double = 0
    var anger: Double = 0
    var fear : Double = 0
    var surprise: Double = 0
    
    
    func get(_ e:Emote) -> Double {
        if e == Emote.Joy {
            return joy
        } else if e == Emote.Sadness {
            return sadness
        } else if e == Emote.Anger {
            return anger
        } else if e == .Surprise {
            return surprise 
        } else if e == .Fear {
            return fear
        }
        return 0.0
    }
    
    static func random() -> DataPoint {
        return DataPoint(joy: Double.random0to1(), sadness: Double.random0to1(), anger: Double.random0to1(), fear: Double.random0to1(), surprise: Double.random0to1())
    }
    
    static func empty() -> DataPoint {
//        print("1")
        return DataPoint(joy: 0.0, sadness: 0.0, anger: 0.0, fear: 0.0, surprise: 0.0)
    }
    
}

enum Emote : String {
    case Joy = "Joy"
    case Sadness = "Sadness"
    case Anger = "Anger"
    case Fear = "Fear"
    case Surprise = "Surprise"
}


typealias day = (DataPoint,(Int,Int))



class CalendarData {
    
    
    var days : [day]!
    var currentDate: (Int,Int)!
    
    init() {
        days = csvParser()
        
        currentDate = (1,3)
    }
    
    func getMonths() -> Int {
        return 4
    }
    
    func getDayCount() -> Int {
        return 122
    }
    
    func getDataOfDay(at i: (Int,Int)) -> DataPoint {
        let j = (i.0+8,i.1)
        for day in days {
            if day.1 == j {
                return day.0
            }
        }
//        print("trolololo")
        return DataPoint.empty()
    }
    
    func getDataOfCurrentDay() -> DataPoint {
        let j = (currentDate.0+8,currentDate.1)
        for day in days {
            let d = day.1
            if j == d {
                return day.0
            }
        }
        return DataPoint.empty()
    }
    
}

var basicOrder = [Emote.Joy,Emote.Fear,Emote.Surprise,Emote.Anger,Emote.Sadness]

var masterCal = CalendarData()

class State {
    
    var scrollPos : [Emote]
    
    init() {
        scrollPos = [Emote.Joy,Emote.Fear,Emote.Surprise,Emote.Anger,Emote.Sadness]
    }
    
    
    func scroll(to e : Emote) -> CGFloat {
        var newO : [Emote] = []
        var iO : Int = 0
        var append = false
        for (i,el) in scrollPos.enumerated() {
            guard append == false else {
                newO.append(el)
                continue
            }
            if el == e {
                iO = i
                append = true
//                print(el.rawValue)
                newO.append(el)
            }
        }
        for i in 0..<iO {
            newO.append(scrollPos[i])
        }
        self.scrollPos = newO
//        print(newO)
        return CGFloat(Double(iO)*2.0*Double.pi/Double(5))
    }
    
    func scroll(to dir: Bool) {
        if dir {
            let e = scrollPos.popLast()
            scrollPos.insert(e!, at: 0)
        } else {
            let e = scrollPos.removeFirst
            scrollPos.insert(e, at: scrollPos.count)
        }
//        print(scrollPos)
    }
}

var masterState = State()

