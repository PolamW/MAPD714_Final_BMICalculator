//
//  CircularProgrssBar.swift
//  MAPD714_Final_BMICalculator
//
//  Created by Po Lam Wong on 11/12/2022.
//  Student ID: 301258847
//

import UIKit

class CircularProgrssBar: UIView {

    public var backgroundLayer: CAShapeLayer!
    public var foregroundLayer: CAShapeLayer!

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        let center = CGPoint(x: width/2, y: height/2)
        let radius = (min(width, height) - lineWidth)/2
        
        let startAngle = -CGFloat.pi/2
        let endAngle = startAngle + 2*CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.darkGray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        
        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = UIColor.systemMint.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
        
        foregroundLayer.strokeEnd = 0
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }

}
