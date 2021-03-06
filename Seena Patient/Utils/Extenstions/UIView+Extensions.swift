//
//  UIView+Extensions.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIView {
    public func enableSkeleton(with color: UIColor = .gray, enable: Bool) {
        isUserInteractionEnabled = !enable
        if enable, !isAnimating() {
            let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            gradientView.tag = -1
            gradientView.backgroundColor = color
            gradientView.layer.cornerRadius = 3
            gradientView.clipsToBounds = true
            addSubview(gradientView)
            gradientView.fillInView(self)
            bringSubviewToFront(gradientView)
            addGradientSublayerWithAnimation(gradientView: gradientView)
        } else if !enable, isAnimating() {
            viewWithTag(-1)?.removeFromSuperview()
        }
    }

    private func isAnimating() -> Bool {
        if viewWithTag(-1) != nil {
            return true
        }
        return false
    }

    private func addGradientSublayerWithAnimation(gradientView: UIView) {
        gradientView.layoutIfNeeded()
        let gradienntLayer = CAGradientLayer(layer: gradientView.layer)
        gradienntLayer.colors = [UIColor.gray.cgColor, UIColor.clear.cgColor]
        gradienntLayer.locations = [0, 1]
        gradienntLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradienntLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradienntLayer.frame = CGRect(x: 0, y: 0, width: gradientView.frame.width, height: gradientView.frame.height)

        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        startPointAnim.fromValue = CGPoint(x: -1, y: 0.5)
        startPointAnim.toValue = CGPoint(x: 1, y: 0.5)

        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = CGPoint(x: 0, y: 0.5)
        endPointAnim.toValue = CGPoint(x: 2, y: 0.5)

        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.5
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity

        gradienntLayer.add(animGroup, forKey: "skeletonAnimation")
        gradientView.layer.addSublayer(gradienntLayer)
        gradientView.updateConstraintsIfNeeded()
        gradientView.layoutIfNeeded()
    }
    func fillInView(_ container: UIView!, spacing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: spacing).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: spacing).isActive = true
    }
}

extension UIView {
    func searchVisualEffectsSubview() -> UIVisualEffectView? {
        if let visualEffectView = self as? UIVisualEffectView {
            return visualEffectView
        } else {
            for subview in subviews {
                if let found = subview.searchVisualEffectsSubview() {
                    return found
                }
            }
        }
        return nil
    }
    /// This is the function to get subViews of a view of a particular type
    /// https://stackoverflow.com/a/45297466/5321670
    func subViews<T: UIView>(type : T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
