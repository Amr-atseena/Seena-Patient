//
//  InfoVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    init() {
        super.init(nibName: InfoVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    deinit {
         debugPrint(InfoVC.className + "Release from Momery")
    }
}
