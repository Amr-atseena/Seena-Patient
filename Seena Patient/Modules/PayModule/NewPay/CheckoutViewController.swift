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

    var limit : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        nextBtn.layer.cornerRadius = 10
        getlimitOfWallet()

//        tabBarController?.tabBar.isHidden = true

    }

    func getlimitOfWallet(){
        APIClientSecond().getWalletLimit { (res) in

            self.limit = res.response.limitWallet
            print(self.limit ?? 0)

        } onError: { (error) in
            print(error)
        }

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
            nextBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
            nextBtn.isUserInteractionEnabled = true
        }
    }

    @IBAction func next(_ sender: Any) {

        UserDefaults.standard.setValue(amountTF.text!, forKey: "amount")

        if Int(amountTF.text ?? "0") ?? 0 < limit ?? 0 {
            showAlertController(title: "Error!", message: "Minumam amount is \(limit ?? 0) EGP", actions: [])
        }else{
            if nextBtn.backgroundColor == #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1){
//                let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
//                let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as? PaymentMethodsViewController
//                newViewController!.modalPresentationStyle = .fullScreen
//                self.present(newViewController!, animated: true, completion: nil)

                            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanQRViewController") as? ScanQRViewController
                            newViewController!.modalPresentationStyle = .fullScreen
                            self.present(newViewController!, animated: true, completion: nil)
                
            }else{

            }
        }


    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
