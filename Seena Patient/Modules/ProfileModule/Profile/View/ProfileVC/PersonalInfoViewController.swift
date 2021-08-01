//
//  PersonalInfoViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/27/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!

    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func back(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }

    @IBAction func finish(_ sender: Any) {
}

}
