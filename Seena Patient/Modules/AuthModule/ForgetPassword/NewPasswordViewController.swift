//
//  NewPasswordViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/4/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    weak var viewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func done(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}
