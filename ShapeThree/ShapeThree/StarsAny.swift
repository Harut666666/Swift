//
//  StarsAny.swift
//  ShapeThree
//
//  Created by Harut on 4/20/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class StarsAny: UIView {

    @IBOutlet weak var inputField: UITextField!
    
    override func draw(_ rect: CGRect) {
        let padding:CGFloat = 40
        let pathRect = CGRect(x: padding, y: padding, width: rect.width - padding, height: rect.width - padding * 2)
        let path = self.starIn(rect: pathRect)
        UIColor.black.setFill()
        path.fill()
    }

     func starIn(rect: CGRect)->UIBezierPath{
        let path = UIBezierPath()
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 1.0)
        
        var pointsOnStar = 5

        if let io = inputField.text, !io.isEmpty{
            pointsOnStar = Int(io)!
        }

       
        
        var angle: CGFloat = CGFloat(CGFloat.pi / 2.0)
        let angleIncrement = CGFloat(Double.pi * 2.0 / Double(pointsOnStar))
        let radius: CGFloat = rect.width / 2.0
        let midRadius: CGFloat = 0.45 * radius
                
        var firstPoint = true
        for _ in 1...pointsOnStar {
           let point = pointFrom(angle: angle, radius: midRadius, offset: center) //1
           let nextPoint = pointFrom(angle: angle + angleIncrement, radius: midRadius, offset: center) //2
           let midPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: radius, offset: center) //3
                    
           //4
           if firstPoint {
              firstPoint = false
              path.move(to: point)
           }
           //5
           path.addLine(to: midPoint)
           path.addLine(to: nextPoint)
           
           angle += angleIncrement //6
        }
        path.close() //7
        return path
    }
    
    private func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
       let x = radius * cos(angle) + offset.x
       let y = radius * sin(angle) + offset.y
            
       return CGPoint(x: x, y: y)
    }
    
    func drawStars(){
           setNeedsDisplay()
    }
    
    @IBAction func starsView(_ sender: UIButton) {
        self.drawStars()
    }
    
}
