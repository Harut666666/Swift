//
//  Canvas.swift
//  CoreGraphicsDrawView
//
//  Created by Harut on 4/26/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth = 1.0
    
    func setStrokeWidth(width:Float){
        self.strokeWidth = Double(width)
    }
    
    func setStrokeColor(color: UIColor){
        self.strokeColor = color
    }
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    var lines = [Line ]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else{return}
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color .cgColor)
            context.setLineWidth(CGFloat(line.srtokeWidth))
            context.setLineCap(.round )
            for (i,p) in line.point.enumerated(){
                if i == 0{
                    context.move(to: p)
                }else{
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(srtokeWidth: Float(strokeWidth), color: strokeColor, point: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.point.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
   
}
