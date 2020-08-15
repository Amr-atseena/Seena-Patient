//
//  CustomizedTabBar.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
@IBDesignable
class CustomizedTabBar: UITabBar {
 // MARK: - Variables
    @objc public var centerButtonActionHandler: () -> Void = {}
    private var centerButtonHeight: CGFloat = 70.0
    private var shapeLayer: CALayer?
    
    override public func draw(_ rect: CGRect) {
        self.addShape()
    }
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        self.setupMiddleButton()
    }
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    private func createPath() -> CGPath {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        // first curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        // second curve up
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        // complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
    private func setupMiddleButton() {
        let centerButton = UIButton(frame: CGRect(x: (self.bounds.width / 2)-(centerButtonHeight/2), y: -40, width: centerButtonHeight, height: centerButtonHeight))
        centerButton.layer.cornerRadius = centerButton.frame.size.width / 2.0
        centerButton.setTitle("pay", for: .normal)
        centerButton.backgroundColor = .red
        centerButton.tintColor = UIColor.white
        //add to the tabbar and add click event
        self.addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(self.centerButtonAction), for: .touchUpInside)
    }
    // Menu Button Touch Action
     @objc func centerButtonAction(sender: UIButton) {
        self.centerButtonActionHandler()
     }
}
