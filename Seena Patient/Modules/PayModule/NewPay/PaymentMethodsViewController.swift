//
//  PaymentMethodsViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class PaymentMethodsViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var myWalletView: UIView!
    @IBOutlet weak var walletImg: UIImageView!
    @IBOutlet weak var installmentView: UIView!
    @IBOutlet weak var installmentImg: UIImageView!
    @IBOutlet weak var valuView: UIView!
    @IBOutlet weak var valuImg: UIImageView!
    @IBOutlet weak var installmentStackView: UIStackView!

    @IBOutlet weak var balanceView: UIView!


    @IBOutlet weak var nextBtn: UIButton!

    @IBOutlet weak var threeMons: UIView!
    @IBOutlet weak var sixMons: UIView!
    @IBOutlet weak var twelveMons: UIView!
    @IBOutlet weak var threeAmount: UILabel!
    @IBOutlet weak var threeDur: UILabel!
    @IBOutlet weak var sixAmount: UILabel!
    @IBOutlet weak var sixDur: UILabel!
    @IBOutlet weak var twelveAmount: UILabel!
    @IBOutlet weak var twelveDur: UILabel!
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var tableView: UITableView!

    var whichInstallment : Int?
    var arrayOfValues = [Int]()
    var oneOfPaymentMethodsSelected: Bool?
    var instPlans = [InstallmentPlansModelResponse]()


    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10

        tableView.isHidden = true

        viewDesign()
        viewActions()
    }

    var docId : Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let amo = Int(UserDefaults.standard.string(forKey: "amount") ?? "") ?? 0

        APIClient().installmentPlans(amount: amo, doctorID: docId ?? 0) { (res) in

            self.instPlans = res.response

            self.tableView.reloadData()

            for ing in res.response {
                print(ing.value)
                self.arrayOfValues.append(ing.value)
                print(self.arrayOfValues)
            }

            //            self.threeAmount.text = "EGP \(self.arrayOfValues[2])"
            //            self.sixAmount.text = "EGP \(self.arrayOfValues[1])"
            //            self.twelveAmount.text = "EGP \(self.arrayOfValues[0])"

        } onError: { (error) in
            self.showAlertController(title: "Error!", message: error, actions: [])
        }
    }



    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

        //        walletImg.image = UIImage(named: "unselected")
        //        installmentImg.image = UIImage(named: "selected")
        //        valuImg.image = UIImage(named: "unselected")


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
        //        installmentStackView.isHidden = true
//        UserDefaults.standard.setValue("2", forKey: "installmentsPayment")
        whichInstallment = 0
        oneOfPaymentMethodsSelected = true
        tableView.isHidden = true

        balanceView.isHidden = false

//        showAlertController(title: "Soon".localized, message: "Will be available soon".localized, actions: [])
    }

    @objc func installmentAction(sender : UITapGestureRecognizer) {

        UserDefaults.standard.setValue("1", forKey: "installmentsPayment")

        installmentImg.image = UIImage(named: "selected")
        walletImg.image = UIImage(named: "unselected")
        valuImg.image = UIImage(named: "unselected")
        oneOfPaymentMethodsSelected = true

        //        installmentStackView.isHidden = false
        tableView.isHidden = false

        installmentStackView.isHidden = true
        balanceView.isHidden = true
    }

    @objc func valuAction(sender : UITapGestureRecognizer) {
        valuImg.image = UIImage(named: "selected")
        installmentImg.image = UIImage(named: "unselected")
        walletImg.image = UIImage(named: "unselected")
        //        installmentStackView.isHidden = true
        whichInstallment = 0
        oneOfPaymentMethodsSelected = false
        tableView.isHidden = true
        balanceView.isHidden = true

        showAlertController(title: "Soon".localized, message: "Will be available soon".localized, actions: [])
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

    var selectedMo : Int?

    @objc func threeMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        unSelectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        whichInstallment = 3
        selectedMo = 4
        UserDefaults.standard.setValue(selectedMo, forKey: "installment_plans_ID")
        UserDefaults.standard.setValue(whichInstallment, forKey: "installmentPeriod")

    }

    @objc func sixMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        unSelectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        whichInstallment = 6
        selectedMo = 3
        UserDefaults.standard.setValue(selectedMo, forKey: "installment_plans_ID")
        UserDefaults.standard.setValue(whichInstallment, forKey: "installmentPeriod")

    }

    @objc func twelveMonsAction(sender : UITapGestureRecognizer) {
        selectedInst(container: twelveMons, amount: twelveAmount, duration: twelveDur)
        unSelectedInst(container: threeMons, amount: threeAmount, duration: threeDur)
        unSelectedInst(container: sixMons, amount: sixAmount, duration: sixDur)
        whichInstallment = 12
        selectedMo = 2
        UserDefaults.standard.setValue(selectedMo, forKey: "installment_plans_ID")
        UserDefaults.standard.setValue(whichInstallment, forKey: "installmentPeriod")

    }

    @IBAction func next(_ sender: Any) {



        if tableView.isHidden == false && selectedMo == nil {
            showAlertController(title: "Error!".toLocalize, message: "Select one of installment plans".toLocalize, actions: [])
        }else if oneOfPaymentMethodsSelected == nil || oneOfPaymentMethodsSelected == false{
            showAlertController(title: "Error!".toLocalize, message: "Select one of payment methods".localized, actions: [])

        }else{
            //            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
            //            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanQRViewController") as? ScanQRViewController
            //            newViewController!.modalPresentationStyle = .fullScreen
            //            self.present(newViewController!, animated: true, completion: nil)




            let amo = UserDefaults.standard.string(forKey: "amount")
            let pay = UserDefaults.standard.string(forKey: "installmentsPayment")
            //        let docId = UserDefaults.standard.string(forKey: "QRCode")
            let inst = UserDefaults.standard.integer(forKey: "installment_plans_ID")

            APIClient().payForDoctor(amount: amo!, paymentMethod: pay!, doctorID: "\(docId ?? 0)", inst: inst) { (res) in
                print(res.response.success)

                UserDefaults.standard.set(res.response.paymentID, forKey: "PAYMENTID")


                let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
                newViewController!.modalPresentationStyle = .fullScreen
                self.present(newViewController!, animated: true, completion: nil)




            } onError: { (error) in
                self.showAlertController(title: "Error!", message: error, actions: [])
            }
            
        }
        

    }
    

}


extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instPlans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentTableViewCell") as? InstallmentTableViewCell
        cell?.amountLbl.text = "EGP \(instPlans[indexPath.row].value)"

        if MOLHLanguage.isArabic(){
            cell?.dutationLbl.text = "\(instPlans[indexPath.row].arName)"
        }else{
            cell?.dutationLbl.text = "\(instPlans[indexPath.row].enName)"
        }


        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(instPlans[indexPath.row].value)
        UserDefaults.standard.setValue(instPlans[indexPath.row].id, forKey: "installment_plans_ID")

        if MOLHLanguage.isArabic() {
            UserDefaults.standard.setValue(instPlans[indexPath.row].arName, forKey: "installmentPeriod")
        }else{
            UserDefaults.standard.setValue(instPlans[indexPath.row].enName, forKey: "installmentPeriod")
        }

        selectedMo = 12313123

        print(instPlans[indexPath.row].months)
        print(instPlans[indexPath.row].enName)
        print(instPlans[indexPath.row].id)


    }

}
