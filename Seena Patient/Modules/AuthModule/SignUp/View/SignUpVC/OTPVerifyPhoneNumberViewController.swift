//
//  OTPVerifyPhoneNumberViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/4/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class OTPVerifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var firstCodeTF: UITextField!
    @IBOutlet weak var secondCodeTF: UITextField!
    @IBOutlet weak var thirdCodeTF: UITextField!
    @IBOutlet weak var fourthCodeTF: UITextField!
    @IBOutlet weak var fifthTF: UITextField!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var countDownLbl: UILabel!


    //    var otpFields: [UITextField] {
//       return [firstCodeTF!, secondCodeTF!, thirdCodeTF!, fourthCodeTF!]
//    }

    var firstName : String?
    var lastName : String?
    var pass : String?
    var phoneNum: String?
    var email : String?
    var birthdate : String?
    var pp : UIImage?

    var count = 59
    var timer : Timer?


    var result: SignUpFirst?
    let progressHUD = ProgressHUD(text: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()

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

        let intLetters = phoneNum!.prefix(3)
        let endLetters = phoneNum!.suffix(2)

        let newString = intLetters + "******" + endLetters   //"+91*******21"
        phoneNumber.text = String(newString)

        firstCodeTF.becomeFirstResponder()

        fourthCodeTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        doneBtn.layer.cornerRadius = 10

    }
//    var abc : [String]! = []

    var abc : String = ""


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        print(firstCodeTF.text!,secondCodeTF.text!,thirdCodeTF.text!,fourthCodeTF.text!)

            // On inputing value to textfield
            if ((textField.text?.count)! < 1  && string.count > 0){
                if(textField == firstCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == secondCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
//                    abc?.append(firstCodeTF.text!)
                    abc = firstCodeTF.text!
                }
                if(textField == thirdCodeTF)
                {
                    fourthCodeTF.becomeFirstResponder()
//                    abc?.append(secondCodeTF.text!)
                    abc = firstCodeTF.text! + secondCodeTF.text!
                }
                if(textField == fourthCodeTF)
                {
                    fifthTF.becomeFirstResponder()
//                    abc?.append(thirdCodeTF.text!)
//                    abc?.append(fourthCodeTF.text!)
                    abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text!

                }

                if(textField == fifthTF)
                {
//                    abc?.append(fourthCodeTF.text!)
                }


//                abc?.append(Int(fourthCodeTF.text!) ?? 0)
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

    @objc func textFieldDidChange(_ textField: UITextField) {
//        abc?.append(fourthCodeTF.text!)
        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!

    }


    @IBAction func done(_ sender: Any) {
//        abc?.append(fourthCodeTF.text!)
        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!

        print(abc)
        self.view.addSubview(progressHUD)

        APIClient().postOTPSignUp(otp: abc.replacedArabicDigitsWithEnglish) { (res) in
            print(res)
            self.progressHUD.removeFromSuperview()

            if res.error?.status == false {
//                let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
//                let okAction = UIAlertAction(title: "Back".localized, style: .default) {  (_) in
//                    _ = self.navigationController?.popViewController(animated: true)
//
//                }
                let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)

                self.showAlertController(title: "Error!".toLocalize, message: (res.error?.validation)! , actions: [okAction])
                
            }else{
                self.login()
//                self.navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)
//            _ = self.navigationController?.popToRootViewController(animated: true)
        }
            
        } onError: { (error) in
            self.progressHUD.removeFromSuperview()

            let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
            self.showAlertController(title: "Error!".toLocalize, message: error , actions: [okAction])
        }



    }


    func login(){

        let user = result?.response?.user
        let status = result?.response?.status

        UserDefaults.standard.set(true, forKey: "Signin")

        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "USER")

        

        if status?.financialProof == true && status?.idType == true &&
            status?.profilePicture == true && status?.residenceProof == true {
            UserDefaults.standard.set(true, forKey: "UploadSignin")
        }
        UserDefaults.standard.set(result?.error?.token, forKey: "TOKEN")



        let id = result?.response?.status?.idType
        let fin = result?.response?.status?.financialProof
        let resd = result?.response?.status?.residenceProof

        if id == false || fin == false || resd == false  {
            UserDefaults.standard.set(false, forKey: "Statuss")
        }else{
            UserDefaults.standard.set(true, forKey: "Statuss")
        }



        if status?.financialProof == true {
            UserDefaults.standard.set(true, forKey: "financialProofLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "financialProofLogin")
        }
        if status?.idType == true {
            UserDefaults.standard.set(true, forKey: "idTypeLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "idTypeLogin")
        }
        if status?.profilePicture == true {
            UserDefaults.standard.set(true, forKey: "profilePictureLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "profilePictureLogin")
        }
        if status?.residenceProof == true {
            UserDefaults.standard.set(true, forKey: "residenceProofLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "residenceProofLogin")
        }



       

//        self.navigationController?.setViewControllers([Home.assembleModule()], animated: true)
        let tabBar = HomeTabBarVC()
        self.present(tabBar, animated: true)

    }




    @IBAction func resendCode(_ sender: Any) {
        resendCodeBtn.isUserInteractionEnabled = false
        resendCodeBtn.setTitleColor(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        count = 59
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)


        APIClient().resendotp { (res) in
            print(res)
        } onError: { (error) in
            self.showAlertController(title: "Error!", message: error, actions: [])
        }




    }






}
