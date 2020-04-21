//
//  Circle.swift
//  ShapeThree
//
//  Created by Harut on 4/20/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class Circle: UIView {

    
   override func draw(_ rect: CGRect) {
         guard let currentContext = UIGraphicsGetCurrentContext() else {
                   return
               }
        drawCircle(using: currentContext)
    }
   
    private func drawCircle(using context: CGContext){
           let centerPoint = CGPoint(x: bounds.size.width/2,y:bounds.size.height/2)
           context.addArc(center: centerPoint, radius: 100, startAngle: CGFloat(0).degreesTORadians, endAngle: CGFloat(360).degreesTORadians, clockwise: true)
           
           
               context.setFillColor(UIColor.orange.cgColor)
               context.fillPath()
           
       }
    func drawCircle(){
           setNeedsDisplay()
    }
}
