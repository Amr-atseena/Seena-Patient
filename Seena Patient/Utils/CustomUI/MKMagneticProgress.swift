//
//  MKMagneticProgress.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//
import UIKit
// swiftlint:disable all
// MARK: - Line Cap Enum
public enum LineCap: Int {
    case round, butt, square
    public func style() -> String {
        switch self {
        case .round:
            return CAShapeLayerLineCap.round.rawValue
        case .butt:
            return CAShapeLayerLineCap.butt.rawValue
        case .square:
            return CAShapeLayerLineCap.square.rawValue
        }
    }
}
// MARK: - Orientation Enum
public enum Orientation: Int {
    case left, top, right, bottom
}
@IBDesignable
open class MKMagneticProgress: UIView {
    // MARK: - Variables
    private let titleLabelWidth: CGFloat = 100
    //private let percentLabel = UILabel(frame: .zero)
    @IBInspectable open var titleLabel = UILabel(frame: .zero)
    /// Stroke background color
    @IBInspectable open var clockwise: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    /// Stroke background color
    @IBInspectable open var backgroundShapeColor: UIColor = UIColor(white: 0.9, alpha: 0.5) {
        didSet {
            updateShapes()
        }
    }
    /// Progress stroke color
    @IBInspectable open var progressShapeColor: UIColor   = .blue {
        didSet {
            updateShapes()
        }
    }
    /// Line width
    @IBInspectable open var lineWidth: CGFloat = 8.0 {
        didSet {
            updateShapes()
        }
    }
    /// Space value
    @IBInspectable open var spaceDegree: CGFloat = 45.0 {
        didSet {
//            if spaceDegree < 45.0{
//                spaceDegree = 45.0
//            }
//
//            if spaceDegree > 135.0{
//                spaceDegree = 135.0
//            }
            layoutSubviews()
            updateShapes()
        }
    }
    /// The progress shapes line width will be the `line width` minus the `inset`.
    @IBInspectable open var inset: CGFloat = 0.0 {
        didSet {
            updateShapes()
        }
    }


    // progress Orientation
    open var orientation: Orientation = .bottom {
        didSet {
            updateShapes()
        }
    }
    /// Progress shapes line cap.
    open var lineCap: LineCap = .round {
        didSet {
            updateShapes()
        }
    }
    /// Returns the current progress.
    @IBInspectable open private(set) var progress: CGFloat {
        set {
            progressShape?.strokeEnd = newValue
        }
        get {
            return progressShape.strokeEnd
        }
    }
    /// Duration for a complete animation from 0.0 to 1.0.
    open var completeDuration: Double = 2.0
    private var backgroundShape: CAShapeLayer!
    private var progressShape: CAShapeLayer!
    private var progressAnimation: CABasicAnimation!
    // MARK: - Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    private func setup() {
        backgroundShape = CAShapeLayer()
        backgroundShape.fillColor = nil
        backgroundShape.strokeColor = backgroundShapeColor.cgColor
        layer.addSublayer(backgroundShape)
        progressShape = CAShapeLayer()
        progressShape.fillColor   = nil
        progressShape.strokeStart = 0.0
        progressShape.strokeEnd   = 0.1
        layer.addSublayer(progressShape)
        progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    }
    // MARK: - Progress Animation
    
    public func setProgress(progress: CGFloat, animated: Bool = true) {
        if progress > 1.0 {
            return
        }
        var start = progressShape.strokeEnd
        if let presentationLayer = progressShape.presentation(){
            if let count = progressShape.animationKeys()?.count, count > 0  {
            start = presentationLayer.strokeEnd
            }
        }
        let duration = abs(Double(progress - start)) * completeDuration
//        percentLabel.text = String(format: percentLabelFormat, progress * 100)
        progressShape.strokeEnd = progress
        if animated {
            progressAnimation.fromValue = start
            progressAnimation.toValue   = progress
            progressAnimation.duration  = duration
            progressShape.add(progressAnimation, forKey: progressAnimation.keyPath)
        }
    }
    // MARK: - Layout
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundShape.frame = bounds
        progressShape.frame   = bounds
        let rect = rectForShape()
        backgroundShape.path = pathForShape(rect: rect).cgPath
        progressShape.path   = pathForShape(rect: rect).cgPath
        self.titleLabel.frame = CGRect(x: (self.bounds.size.width - titleLabelWidth)/2, y: self.bounds.size.height-50, width: titleLabelWidth, height: 42)
        updateShapes()
    }
    private func updateShapes() {
        backgroundShape?.lineWidth  = lineWidth
        backgroundShape?.strokeColor = backgroundShapeColor.cgColor
        backgroundShape?.lineCap     = CAShapeLayerLineCap(rawValue: lineCap.style())
        progressShape?.strokeColor = progressShapeColor.cgColor
        progressShape?.lineWidth   = lineWidth - inset
        progressShape?.lineCap     = CAShapeLayerLineCap(rawValue: lineCap.style())
        switch orientation {
        case .left:
            titleLabel.isHidden = true
            self.progressShape.transform = CATransform3DMakeRotation( CGFloat.pi / 2, 0, 0, 1.0)
            self.backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1.0)
        case .right:
            titleLabel.isHidden = true
            self.progressShape.transform = CATransform3DMakeRotation( CGFloat.pi * 1.5, 0, 0, 1.0)
            self.backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi * 1.5, 0, 0, 1.0)
        case .bottom:
            titleLabel.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [] , animations: { [weak self] in
                if let temp = self{
                    temp.titleLabel.frame = CGRect(x: (temp.bounds.size.width - temp.titleLabelWidth)/2, y: temp.bounds.size.height-50, width: temp.titleLabelWidth, height: 42)
                }

            }, completion: nil)
            self.progressShape.transform = CATransform3DMakeRotation( CGFloat.pi * 2, 0, 0, 1.0)
            self.backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi * 2, 0, 0, 1.0)
        case .top:
            titleLabel.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [] , animations: { [weak self] in
                if let temp = self{
                    temp.titleLabel.frame = CGRect(x: (temp.bounds.size.width - temp.titleLabelWidth)/2, y: 0, width: temp.titleLabelWidth, height: 42)
                }
                }, completion: nil)
            self.progressShape.transform = CATransform3DMakeRotation( CGFloat.pi, 0, 0, 1.0)
            self.backgroundShape.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1.0)
        }
    }
    // MARK: - Helper
    private func rectForShape() -> CGRect {
        return bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
    }
    private func pathForShape(rect: CGRect) -> UIBezierPath {
        let startAngle:CGFloat!
        let endAngle:CGFloat!
        if clockwise{
            startAngle = CGFloat(spaceDegree * .pi / 180.0) + (0.5 * .pi)
            endAngle = CGFloat((360.0 - spaceDegree) * (.pi / 180.0)) + (0.5 * .pi)
        }else{
            startAngle = CGFloat((360.0 - spaceDegree) * (.pi / 180.0)) + (0.5 * .pi)
            endAngle = CGFloat(spaceDegree * .pi / 180.0) + (0.5 * .pi)
        }
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width / 2.0, startAngle: startAngle, endAngle: endAngle
            , clockwise: clockwise)
        return path
    }
}
