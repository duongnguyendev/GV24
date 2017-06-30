//
//  JobAssignedDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobAssignedDetailVC: BaseVC,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var taskAssigned = Task()
    var delegate: TaskManageDelegate?
    
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView : UIView = {
        //content all view
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleProfileButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let conformedMaid: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = LanguageManager.shared.localized(string: "IdentifyYourPartners")
        button.addTarget(self, action: #selector(handleConformMaid(_:)), for: .touchUpInside)
        button.sizeImage = 20
        button.color = AppColor.backButton
        button.iconName = .logIn
        return button
    }()
    
    let descLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "Description")
        lb.textColor = AppColor.lightGray
        return lb
    }()

    let descTaskView: DescTaskView = {
        let view = DescTaskView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.homeButton1
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.sizeImage = 30
        button.title = LanguageManager.shared.localized(string: "DeleteWork")
        button.backgroundColor = UIColor.white
        button.iconName = .iosTrash
        return button
    }()
    
    func handleProfileButton(_ sender: UIButton){
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = taskAssigned.stakeholder?.receivced
        push(viewController: maidProfileVC)
        print("Handle Profile Button")
    }
    func handleConformMaid(_ sender: UIButton){
        self.handleTakePhoto()
        print("Handle Comform Task")
    }
    func handleTakePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.showImagePickerWith(sourceType: .camera)
        }else{
            print("Camera not availble.")
        }
    }
    func handleSelectFromGallery(){
        showImagePickerWith(sourceType: .photoLibrary)
    }
    func showImagePickerWith(sourceType : UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - handle image picker controller delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            let imageResized = image.resize(newWidth: 200)
            self.activity.startAnimating()
            self.deleteButton.isUserInteractionEnabled = false
            TaskService.shared.checkInMaid(task: taskAssigned, img_checkin: imageResized, completion: { (flag) in
                self.activity.stopAnimating()
                if flag!{
                    self.showAlertWith(message: LanguageManager.shared.localized(string: "PartnerIdentifiedSuccessfully")!, completion: { 
                        self.delegate?.checkInMaid!()
                        self.dismiss(animated: true, completion: nil)
                    })
                }else{
                    self.showAlertWith(message: LanguageManager.shared.localized(string: "FailedToIdentify")!, completion: {
                    })
                }
                self.deleteButton.isUserInteractionEnabled = true
            })
            picker.dismiss(animated: true, completion: nil)
        }
    }
    //MARK: - Show Message
    func showAlertWith(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertDelete(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .default, handler: { (nil) in
            completion()
        }))
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "Cancel"), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func handleRemoveTask(_ sender: UIButton){
        showAlertDelete(message: LanguageManager.shared.localized(string: "AreYouSureYouWantToDeleteThisWork")!) {
            self.activity.startAnimating()
            TaskService.shared.deleteTask(task: self.taskAssigned, completion: { (flag) in
                 self.activity.stopAnimating()
                if (flag!){
                    self.goBack()
                }else{
                    self.showAlertWith(message: LanguageManager.shared.localized(string: "FailedToDelete")!, completion: {})
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = taskAssigned
        self.profileButton.received = taskAssigned.stakeholder?.receivced
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(mainScrollView)
        self.mainScrollView.addSubview(contentView)
        self.contentView.addSubview(profileButton)
        self.contentView.addSubview(conformedMaid)
        self.contentView.addSubview(descTaskView)
        self.contentView.addSubview(deleteButton)
        self.view.addSubview(descLabel)
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true

        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: conformedMaid)
        conformedMaid.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 1).isActive = true
        conformedMaid.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: conformedMaid.bottomAnchor, constant: 20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        descTaskView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    override func localized() {
        super.localized()
        title = LanguageManager.shared.localized(string: "InProcess")
    }
}
