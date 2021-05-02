//
//  OTPViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        viewDesign()

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
        let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentSuccessViewController") as? PaymentSuccessViewController
        newViewController!.modalPresentationStyle = .fullScreen
        self.present(newViewController!, animated: true, completion: nil)
    }


}
