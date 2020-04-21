//
//  TriangleAndRectangle.swift
//  ShapeThree
//
//  Created by Harut on 4/20/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit
enum Shape{
    case triangle
    case rectangle
}

extension FloatingPoint{
    var degreesTORadians: Self {
        return self * .pi / 180
    }
}
//@IBDesignable

class TriangleAndRectangle: UIView {

    var currentShape: Shape?
   
    override func draw(_ rect: CGRect) {
        guard let currentContext = UIGraphicsGetCurrentContext(), let currentShape = currentShape else {
            return
        }
        switch currentShape {
        case .triangle:
            drawTriangel(using: currentContext)
        case .rectangle:
            drawRectangle(using: currentContext)
        }

    }
   
    private func drawTriangel(using context: CGContext){
        let strokeDistance: CGFloat = 50
              let centerPoint = CGPoint(x: bounds.size.width/2,y:bounds.size.height/2)
              let lowerLeftCorent = CGPoint(x: centerPoint.x - strokeDistance,y:centerPoint.y + strokeDistance)
              let lowerRightRorner = CGPoint(x: centerPoint.x + strokeDistance,y:centerPoint.y + strokeDistance)
              let upperRightCorner = CGPoint(x: centerPoint.x + strokeDistance,y:centerPoint.y - strokeDistance * 2)
              let upperLeftCorner = CGPoint(x: centerPoint.x + strokeDistance,y:centerPoint.y - strokeDistance * 2)
              
              context.move(to: lowerLeftCorent)
              context.addLine(to: lowerLeftCorent)
              context.addLine(to: lowerRightRorner)
              context.addLine(to: upperRightCorner)
              context.addLine(to: upperLeftCorner)
              context.addLine(to: lowerLeftCorent)
              context.setLineCap(.square)
              
                  context.setFillColor(UIColor.red.cgColor)
                  context.fillPath()
    }
    private func drawRectangle(using context: CGContext){
        let strokeDistance: CGFloat = 50
              let centerPoint = CGPoint(x: bounds.size.width/2,y:bounds.size.height/2)
              let lowerLeftCorent = CGPoint(x: centerPoint.x - strokeDistance,y:centerPoint.y + strokeDistance)
              let lowerRightRorner = CGPoint(x: centerPoint.x + strokeDistance,y:centerPoint.y + strokeDistance)
              let upperRightCorner = CGPoint(x: centerPoint.x + strokeDistance,y:centerPoint.y - strokeDistance * 2)
              let upperLeftCorner = CGPoint(x: centerPoint.x - strokeDistance,y:centerPoint.y - strokeDistance * 2)
              
              context.move(to: lowerLeftCorent)
              context.addLine(to: lowerLeftCorent)
              context.addLine(to: lowerRightRorner)
              context.addLine(to: upperRightCorner)
              context.addLine(to: upperLeftCorner)
              context.addLine(to: lowerLeftCorent)
              context.setLineCap(.square)
              
                  context.setFillColor(UIColor.blue.cgColor)
                  context.fillPath()
    }
    func drawShape(selectedShape:Shape){
        currentShape = selectedShape
        setNeedsDisplay()
    }
    
    @IBAction func triangle(_ sender: UIButton) {
        self.drawShape(selectedShape: .triangle)
    }
    @IBAction func rectangle(_ sender: UIButton) {
        self.drawShape(selectedShape: .rectangle)

    }
}
