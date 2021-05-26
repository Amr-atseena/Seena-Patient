//
//  SeenaPaySuccViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class SeenaPaySuccViewController: UIViewController {

    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantAddress: UILabel!
    @IBOutlet weak var amountPaid: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var containerView: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 10

        // border
//        blueView.layer.borderWidth = 1.0
//        blueView.layer.borderColor = UIColor.black.cgColor

        // shadow
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 4.0

    }
    

    @IBAction func finish(_ sender: Any) {
        let controller = HomeTabBarVC()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }

}
