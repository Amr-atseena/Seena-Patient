//
//  OTPViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class OTPViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var backBtn: UIButton!


    var fullOTP : String = ""
    let progressHUD = ProgressHUD(text: "")



    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.layer.cornerRadius = 10

        print(UserDefaults.standard.string(forKey: "amount")!)

        print(UserDefaults.standard.string(forKey: "installmentsPayment")!)

//        print(UserDefaults.standard.string(forKey: "QRCode")!)

        print(UserDefaults.standard.integer(forKey: "installment_plans_ID"))


        viewDesign()

    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    func viewDesign(){
        //Main view
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]

        firstTF.delegate = self
        secondTF.delegate = self
        thirdTF.delegate = self
        fourthTF.delegate = self
        
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // On inputing value to textfield
            if ((textField.text?.count)! < 1  && string.count > 0){
                if(textField == firstTF)
                {
                    secondTF.becomeFirstResponder()
                }
                if(textField == secondTF)
                {
                    thirdTF.becomeFirstResponder()
                }
                if(textField == thirdTF)
                {
                    fourthTF.becomeFirstResponder()
                }

                textField.text = string
                return false
            }
            else if ((textField.text?.count)! >= 1  && string.count == 0){
                // on deleting value from Textfield
                if(textField == secondTF)
                {
                    firstTF.becomeFirstResponder()
                }
                if(textField == thirdTF)
                {
                    secondTF.becomeFirstResponder()
                }
                if(textField == fourthTF)
                {
                    thirdTF.becomeFirstResponder()
                }
                textField.text = ""
                return false
            }
            else if ((textField.text?.count)! >= 1  )
            {
                textField.text = string
                return false
            }
            return true
        }



    @IBAction func done(_ sender: Any) {
        self.view.addSubview(progressHUD)

        fullOTP = firstTF.text! + secondTF.text! + thirdTF.text! + fourthTF.text!

//        if MOLHLanguage.isArabic(){
//            fullOTP = fourthTF.text! + thirdTF.text! + secondTF.text! + firstTF.text!
//        }else{
//            fullOTP = firstTF.text! + secondTF.text! + thirdTF.text! + fourthTF.text!
//        }
        print(fullOTP)

        if firstTF.text == "" ||  secondTF.text == "" || thirdTF.text == "" || fourthTF.text == "" {

            self.progressHUD.removeFromSuperview()
            showAlertController(title: "Error!".localized, message: "Please fill all fields".localized, actions: [])

        }else{

            APIClient().transferCompleteOTP(otp: Int(fullOTP)!) { (res) in
                self.progressHUD.removeFromSuperview()

                print(res)

                UserDefaults.standard.setValue(res.response.doctor.name, forKey: "doctorName")
                UserDefaults.standard.setValue(res.response.createdAt, forKey: "paymentDate")
                UserDefaults.standard.setValue(res.response.doctor.image, forKey: "doctorImage")

                let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentSuccessViewController") as? PaymentSuccessViewController
                newViewController!.modalPresentationStyle = .fullScreen
                self.present(newViewController!, animated: true, completion: nil)
            } onError: { (error) in
                self.progressHUD.removeFromSuperview()
                self.showAlertController(title: "Error!".localized, message: error, actions: [])
            }


        }



    }


}
