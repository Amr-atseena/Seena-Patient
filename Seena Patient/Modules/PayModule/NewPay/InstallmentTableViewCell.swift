//
//  InstallmentTableViewCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dutationLbl: UILabel!
    @IBOutlet weak var container: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func layoutSubviews() {
//          super.layoutSubviews()
//          //set the values for top,left,bottom,right margins
//          let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//          contentView.frame = contentView.frame.inset(by: margins)
//
//
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
//        contentView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner ,.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        if selected {
//                self.selectionStyle = .none
//                self.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.6941176471, blue: 0.8862745098, alpha: 1)
//            amountLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            dutationLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//            } else {
//                self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                amountLbl.textColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
//                dutationLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            }
//    }



    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
//          let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        container.frame = contentView.frame.inset(by: margins)


        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        container.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner ,.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.layer.borderWidth = 2
        container.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
                self.selectionStyle = .none
            self.container.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.6941176471, blue: 0.8862745098, alpha: 1)
            amountLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            dutationLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

            } else {
                self.container.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                amountLbl.textColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
                dutationLbl.textColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
            }
    }

}
