//
//  OTPForgetPasswordViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/2/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class OTPForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UILabel!
    @IBOutlet weak var firstCodeTF: UITextField!
    @IBOutlet weak var secondCodeTF: UITextField!
    @IBOutlet weak var thirdCodeTF: UITextField!
    @IBOutlet weak var fourthCodeTF: UITextField!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var countDownLbl: UILabel!

    var abc : String = ""
    var userPhoneNum : String?
    let progressHUD = ProgressHUD(text: "")
    var count = 59
    var timer : Timer?


    override func viewDidLoad() {
        super.viewDidLoad()

        viewDesign()

        doneBtn.layer.cornerRadius = 10

        resendCodeBtn.isUserInteractionEnabled = false
        resendCodeBtn.setTitleColor(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)



    }

    @objc func updateCounter() {
        if count > 0 {
            print("\(count) seconds to the end of the world")
            count -= 1
            countDownLbl.text = "00:\(count)"
        }

        if count == 0 {
            timer?.invalidate()
            timer = nil
            resendCodeBtn.isUserInteractionEnabled = true
            resendCodeBtn.setTitleColor(#colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1), for: .normal)
        }

    }
    
    func viewDesign(){
        //Main view
        firstCodeTF.delegate = self
        secondCodeTF.delegate = self
        thirdCodeTF.delegate = self
        fourthCodeTF.delegate = self

        let intLetters = userPhoneNum!.prefix(3)
        let endLetters = userPhoneNum!.suffix(2)

        let newString = intLetters + "******" + endLetters   //"+91*******21"
        phoneNumberTF.text = String(newString)

        doneBtn.layer.cornerRadius = 10

        fourthCodeTF.addTarget(self, action: #selector(myTargetFunction), for: UIControl.Event.editingDidEnd)


    }

    @objc func myTargetFunction(textField: UITextField) {
        otpCall()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // On inputing value to textfield
            if ((textField.text?.count)! < 1  && string.count > 0){
                if(textField == firstCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == secondCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
                    abc = firstCodeTF.text!
                }
                if(textField == thirdCodeTF)
                {
                    fourthCodeTF.becomeFirstResponder()
                    abc = firstCodeTF.text! + secondCodeTF.text!
                }
                if(textField == fourthCodeTF)
                {
                    abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text!

                }

                textField.text = string
                print(abc)
                return false
            }
            else if ((textField.text?.count)! >= 1  && string.count == 0){
                // on deleting value from Textfield
                if(textField == secondCodeTF)
                {
                    firstCodeTF.becomeFirstResponder()
                }
                if(textField == thirdCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == fourthCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
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

        otpCall()

    }


    func otpCall(){
        self.view.addSubview(progressHUD)

        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!


        APIClient().checkResetPass(phone: userPhoneNum!, resetOTP: abc) { (res) in
            print(res)
            self.progressHUD.removeFromSuperview()

            if res.error.status == false{
                let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

                self.showAlertController(title: "Error!".toLocalize, message: res.error.validation, actions: [okAction])
            }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController
            newViewController!.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(newViewController!, animated: true)
            }
        } onError: { (error) in
            print(error)
            self.progressHUD.removeFromSuperview()

            let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

            self.showAlertController(title: "Error!".toLocalize, message: error, actions: [okAction])
        }
    }



    @IBAction func resendCode(_ sender: Any) {
        resendCodeBtn.isUserInteractionEnabled = false
        resendCodeBtn.setTitleColor(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        count = 59
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)


        self.view.addSubview(progressHUD)


        APIClient().forgetPassword(phone: userPhoneNum ?? "") { (res) in
            print(res)

            self.progressHUD.removeFromSuperview()


        } onError: { (error) in

            self.progressHUD.removeFromSuperview()
            let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

            self.showAlertController(title: "Error!".toLocalize, message: error, actions: [okAction])
        }




    }




}
