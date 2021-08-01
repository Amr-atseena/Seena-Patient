//
//  ProfileViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tagView: UIView!

    var presenter: ProfilePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

//        profileLbl.text = presenter.localization.profile
        profileLbl.font = DesignSystem.Typography.heading.font
    }
    var localDataManager: ProfileLocalDataManagerProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        holderView.isHidden = true
        retriveUser()
    }

    func retriveUser() -> User? {
        let data = UserDefaults.standard.data(forKey: "USER")
        let user = try? JSONDecoder().decode(User.self, from: data ?? Data())
//        userNameLbl.text = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
//        statusLbl.text = user?.status
//        userImage.kf.setImage(with: URL(string: user?.image ?? ""))

        updateProfile(userName: "\(user?.firstName ?? "") \(user?.lastName ?? "")", image: user?.image ?? "")
        onRetrieApplicationStatusSuccess(user?.status ?? "")

        return user
    }


    func onRetrieApplicationStatusSuccess(_ status: String) {
        switch status {
        case "pending":
            setApplicationStatus(status: "pending".toLocalize, color: DesignSystem.Colors.pending.color)
        case "قيد الأنتظار":
            setApplicationStatus(status: "pending".toLocalize, color: DesignSystem.Colors.pending.color)
        case "activate":
            setApplicationStatus(status: "activate".localized, color: DesignSystem.Colors.accept.color)
        case "فعال":
            setApplicationStatus(status: "activate".localized, color: DesignSystem.Colors.accept.color)
        case "rejected":
           setApplicationStatus(status: "rejected".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "مرفوض":
            setApplicationStatus(status: "rejected".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "missing info":
            setApplicationStatus(status: "missing info".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "فاقد معلومات":
            setApplicationStatus(status: "missing info".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "Inactive":
            setApplicationStatus(status: "Inactive".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "غير فعال":
            setApplicationStatus(status: "Inactive".localized, color: DesignSystem.Colors.primaryActionBackground.color)

        default:
//            view?.setApplicationStatus(status: status, color: DesignSystem.Colors.primaryActionBackground.color)
            setApplicationStatus(status: status, color: .clear)
        }
    }


    func updateProfile(userName: String, image: String) {
        userNameLbl.text = userName
        userImage.kf.setImage(with: URL(string: image))
    }
    func setApplicationStatus(status: String, color: UIColor) {
        statusLbl.text = status
        holderView.isHidden = false
        tagView.backgroundColor = color
        UIView.animate(withDuration: 0.3) {
            self.tagView.layoutIfNeeded()
        }
    }
    func hideApplicationStatus() {
        holderView.isHidden = true
    }


    @IBAction func changeProfilePic(_ sender: Any) {

        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)

        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        userImage.image = image

    }



}
