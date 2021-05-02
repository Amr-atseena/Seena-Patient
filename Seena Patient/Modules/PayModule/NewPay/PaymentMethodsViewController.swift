//
//  PaymentMethodsViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class PaymentMethodsViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var myWalletView: UIView!
    @IBOutlet weak var walletImg: UIImageView!
    @IBOutlet weak var installmentView: UIView!
    @IBOutlet weak var installmentImg: UIImageView!
    @IBOutlet weak var valuView: UIView!
    @IBOutlet weak var valuImg: UIImageView!
    @IBOutlet weak var installmentStackView: UIStackView!

    @IBOutlet weak var threeMons: UIView!
    @IBOutlet weak var sixMons: UIView!
    @IBOutlet weak var twelveMons: UIView!
    @IBOutlet weak var threeAmount: UILabel!
    @IBOutlet weak var threeDur: UILabel!
    @IBOutlet weak var sixAmount: UILabel!
    @IBOutlet weak var sixDur: UILabel!
    @IBOutlet weak var twelveAmount: UILabel!
    @IBOutlet weak var twelveDur: UILabel!

    var whichInstallment : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewDesign()
        viewActions()
    }

    func viewDesign(){
        //Main view
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]
        installmentStackView.isHidden = true

        unSelectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        unSelectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        whichInstallment = 0
    }

    func viewActions(){
        let walletViewAction = UITapGestureRecognizer(target: self, action:  #selector(self.walletAction))
        self.myWalletView.addGestureRecognizer(walletViewAction)

        let installmentViewAction = UITapGestureRecognizer(target: self, action:  #selector(self.installmentAction))
        self.installmentView.addGestureRecognizer(installmentViewAction)

        let valuViewAction = UITapGestureRecognizer(target: self, action:  #selector(self.valuAction))
        self.valuView.addGestureRecognizer(valuViewAction)



        let three = UITapGestureRecognizer(target: self, action:  #selector(self.threeMonsAction))
        self.threeMons.addGestureRecognizer(three)

        let six = UITapGestureRecognizer(target: self, action:  #selector(self.sixMonsAction))
        self.sixMons.addGestureRecognizer(six)

        let twelve = UITapGestureRecognizer(target: self, action:  #selector(self.twelveMonsAction))
        self.twelveMons.addGestureRecognizer(twelve)
    }

    @objc func walletAction(sender : UITapGestureRecognizer) {
        walletImg.image = UIImage(named: "selected")
        installmentImg.image = UIImage(named: "unselected")
        valuImg.image = UIImage(named: "unselected")
        installmentStackView.isHidden = true
        whichInstallment = 0
    }

    @objc func installmentAction(sender : UITapGestureRecognizer) {
        installmentImg.image = UIImage(named: "selected")
        walletImg.image = UIImage(named: "unselected")
        valuImg.image = UIImage(named: "unselected")

        installmentStackView.isHidden = false
    }

    @objc func valuAction(sender : UITapGestureRecognizer) {
        valuImg.image = UIImage(named: "selected")
        installmentImg.image = UIImage(named: "unselected")
        walletImg.image = UIImage(named: "unselected")
        installmentStackView.isHidden = true
        whichInstallment = 0
    }


    func selectedInst(container:UIView, amount : UILabel, duration: UILabel){
        container.backgroundColor = #colorLiteral(red: 0, green: 0.6078431373, blue: 0.7764705882, alpha: 1)
        amount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        duration.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        container.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner ,.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.layer.borderWidth = 2
        container.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
    }

    func unSelectedInst(container:UIView, amount : UILabel, duration: UILabel){
        container.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        amount.textColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
        duration.textColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        container.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner ,.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.layer.borderWidth = 2
        container.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
    }


    @objc func threeMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        unSelectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        whichInstallment = 3
    }

    @objc func sixMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        unSelectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        whichInstallment = 6
    }

    @objc func twelveMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        unSelectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        whichInstallment = 12
    }

    @IBAction func next(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanQRViewController") as? ScanQRViewController
        newViewController!.modalPresentationStyle = .fullScreen
        self.present(newViewController!, animated: true, completion: nil)
    }
    

}
