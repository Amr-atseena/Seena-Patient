//
//  CheckoutViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
    }

    func viewDesign(){
        //Main view
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]

        // Next button
        nextBtn.isUserInteractionEnabled = false
        amountTF.addTarget(self, action: #selector(CheckoutViewController.textFieldDidChange(_:)), for: .allEvents)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if amountTF.text == ""{
            nextBtn.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
            nextBtn.isUserInteractionEnabled = false
        }else{
        nextBtn.backgroundColor = .red
        nextBtn.isUserInteractionEnabled = true
        }
    }

    @IBAction func next(_ sender: Any) {

        UserDefaults.standard.setValue(amountTF.text!, forKey: "amount")

        if nextBtn.backgroundColor == .red{
        let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as? PaymentMethodsViewController
        newViewController!.modalPresentationStyle = .fullScreen
        self.present(newViewController!, animated: true, completion: nil)
        }else{

        }
    }

}
