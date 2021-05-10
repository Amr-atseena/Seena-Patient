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

    var abc : String = ""
    var userPhoneNum : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewDesign()
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

        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!


        APIClient().checkResetPass(phone: userPhoneNum!, resetOTP: abc) { (res) in
            print(res)

            if res.error.status == false{
                self.showAlertController(title: "Error!", message: res.error.validation, actions: [])
            }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController
            newViewController!.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(newViewController!, animated: true)
            }
        } onError: { (error) in
            print(error)
            self.showAlertController(title: "Error!", message: error, actions: [])
        }






    }

}
