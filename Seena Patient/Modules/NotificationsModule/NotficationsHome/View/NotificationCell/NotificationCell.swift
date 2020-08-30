//
//  notificationCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet private var notifcationTitleLabel: UILabel!
    @IBOutlet private var notificationBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // notificationTitle Label
        notifcationTitleLabel.textColor = DesignSystem.Colors.secondaryText.color
        notifcationTitleLabel.font = DesignSystem.Typography.subHeading3.font
        // notificationBody Label
        notificationBodyLabel.textColor = DesignSystem.Colors.primaryText.color
        notificationBodyLabel.font = DesignSystem.Typography.title3.font
    }
}
