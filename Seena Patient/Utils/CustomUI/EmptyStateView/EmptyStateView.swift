//
//  EmptyStateView.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 25/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
@IBDesignable
class EmptyStateView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var noResultsHeaderKeywordLabel: UILabel!
    @IBOutlet private var noResultsbodyKeywordLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        self.contentView = loadViewFromNib()
        addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: EmptyStateView.className, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return view
    }
    private func setupView() {
        // noResultsHeaderKeyword Label
        noResultsHeaderKeywordLabel.text = "We tried looking;".localized
      noResultsHeaderKeywordLabel.textColor = DesignSystem.Colors.primaryText.color
        noResultsHeaderKeywordLabel.font = DesignSystem.Typography.title2.font
        // noResultsbodyKeyword Label
        noResultsbodyKeywordLabel.text =  "found nothing!".localized
        noResultsbodyKeywordLabel.textColor = DesignSystem.Colors.primaryText.color
        noResultsbodyKeywordLabel.font = DesignSystem.Typography.title2.font
    }
}
