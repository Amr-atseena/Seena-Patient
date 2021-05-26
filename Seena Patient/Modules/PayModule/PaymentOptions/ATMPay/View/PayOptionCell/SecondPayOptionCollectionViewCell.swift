//
//  SecondPayOptionCollectionViewCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/25/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class SecondPayOptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trueImage: UIImageView!
    @IBOutlet weak var merchantNo: UITextField!
    @IBOutlet weak var amountPaid: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        merchantNo.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        amountPaid.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)


    }


    @objc final private func textFieldDidChange(textField: UITextField){

        UserDefaults.standard.setValue(merchantNo.text, forKey: "merchant")
        UserDefaults.standard.setValue(amountPaid.text, forKey: "amount")
        


    }

//    func textViewDidEndEditing(_ textView: UITextView) {
//
//      // Run code here for when user ends editing text view
//
//    }

    func setSeenaPay(merchant : String , amount : String) {
        merchantNo.text = merchant
        amountPaid.text = amount
    }

}
