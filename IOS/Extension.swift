//
//  Extension.swift
//  moodAI
//
//  Created by dereck mcduff on 17-12-02.
//  Copyright © 2017 DandS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CSV


func csvParser() -> [day] {
    
    
    if let fileUrl = Bundle.main.url(forResource: "depressionTrainSetWithDates", withExtension:"csv") {
        if let text = try? String(contentsOf: fileUrl, encoding: String.Encoding.utf8)  {
            let rows = text.components(separatedBy: "\n")
            let cols = rows.map({$0.components(separatedBy: ",")})
            var days:[day] = []
            for (i,col) in cols.enumerated() {
                
                guard i > 1 && col[0] != "88" && col.count>3 else {
                    continue
                }
                var c = col
                var newCol : [String] = []
                for j in 0...7 {newCol.append(c.popLast()!)}
                newCol.reverse()
                
                let dp = DataPoint.init(joy: Double(newCol[0])!, sadness: Double(newCol[1])!, anger: Double(newCol[2])!, fear: Double(newCol[3])!, surprise: Double(newCol[4])!)
                let d = (Int(newCol[5])!,Int(newCol[6])!)
                var day = (dp,d)
                days.append(day)
                
            }
            
            return days
            
        } else {
            print("error reading file")
        }
        
    }
    return [day(DataPoint.empty(),(12,3))]
}

func get() {
    let url = URL(string: "https://d95d4908.ngrok.io/" + "Imdepressive")
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        if let data = data,
            let html = String(data: data, encoding: String.Encoding.utf8) {
            print(html)
        }
    }
    task.resume()
}

func helloHTTP() {
    
    
    
//    let json: [String: Any] = ["text":"l"]
//    
//    let jsonData = try? JSONSerialization.data(withJSONObject: json) as Data
//    
//    // create post request
//    let url = URL(string: "https://daabf58e.ngrok.io")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    
//    // insert json data to the request
//    request.httpBody = jsonData
//    
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data, error == nil else {
//            print(error?.localizedDescription ?? "No data")
//            return
//        }
//        print(response)
//        
//        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//        print(responseJSON)
//        if let responseJSON = responseJSON as? [String: Any] {
//            print(responseJSON)
//        }
//    }
//    
//    task.resume()
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    
    static func random(with alpha : CGFloat = 1.0) -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: alpha)
    }
    
    
}

func emotes (_ emo: Emote) -> UIColor {
    switch emo {
    case .Anger:
        return #colorLiteral(red: 0.9817218184, green: 0, blue: 0.07586532086, alpha: 1)
    case .Joy:
        return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    case .Sadness:
        return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    case .Surprise:
        return #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    case .Fear:
        return #colorLiteral(red: 0, green: 0.6539773345, blue: 0, alpha: 1)
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 40) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func addLine(with points: [CGPoint]) -> CAShapeLayer {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: points.first!)
        for p in points.dropFirst() {
            linePath.addLine(to: p)
        }
        linePath.addLine(to: points.first!)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.layer.addSublayer(line)
        return line
    }
}

extension CAGradientLayer {
    
    func setDirection(with angle: Int) {
        
        if angle <= 45 {
            let shift = (tan(Double(angle).toRadian())*0.5).rounded(1)
            self.startPoint = CGPoint(x: 0, y: 0.5+shift)
            self.endPoint = CGPoint(x: 1, y: 0.5-shift)
        } else if angle <= 90 {
            let shift = (tan(Double(90-angle).toRadian())*0.5).rounded(1)
            self.startPoint = CGPoint(x: 0.5-shift, y: 1)
            self.endPoint = CGPoint(x: 0.5+shift, y: 0)
        } else if angle <= 135 {
            let shift = (tan(Double(angle-90).toRadian())*0.5).rounded(1)
            self.startPoint = CGPoint(x: 0.5+shift, y: 1)
            self.endPoint = CGPoint(x: 0.5-shift, y: 0)
        } else if angle <= 180 {
            let shift = (tan(Double(angle-135).toRadian())*0.5).rounded(1)
            self.startPoint = CGPoint(x: 1, y: 1-shift)
            self.endPoint = CGPoint(x: 0, y: 0+shift)
        }
    }
}

extension Double {
    
    func rounded(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toRadian()->Double{
        return (self*Double.pi/180.0)
    }
    
    private static let arc4randomMax = Double(UInt32.max)
    
    static func random0to1() -> Double {
        return Double(arc4random()) / arc4randomMax
    }
}

extension UILabel {
    
    func customActive() {
        self.textColor = UIColor.black.withAlphaComponent(0.4)
        self.font = UIFont.systemFont(ofSize: 22)
    }
    
    func customSelected() {
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }

}


class GameHelper {
    
    static func rad2deg( rad:Float ) -> Float {
        return rad * (Float) (180.0 /  Double.pi)
    }
    
    static func deg2rad( deg:Float ) -> Float{
        return deg * (Float)(Double.pi / 180)
    }
    
    static func getPanDirection(velocity: CGPoint) -> String {
        var panDirection:String = ""
        if ( velocity.x > 0 && velocity.x > abs(velocity.y) || velocity.x < 0 && abs(velocity.x) > abs(velocity.y) ){
            panDirection = "horizontal"
        }
        
        if ( velocity.y < 0 && abs(velocity.y) > abs(velocity.x) || velocity.y > 0 &&  velocity.y  > abs(velocity.x)) {
            panDirection = "vertical"
        }
        
        
        return panDirection
    }
    
}

class IgnoreTouchView : UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}

class IgnoreImageView : UIImageView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}
