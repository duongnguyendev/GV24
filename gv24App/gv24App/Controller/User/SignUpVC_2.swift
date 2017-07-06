//
//  SignUpVC_2.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/8/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import CoreLocation

class SignUpVC_2: BaseVC, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate : UserEventDelegate?
    let itemSize : CGFloat = 50
    var userInfo : Dictionary<String, String>?
    var gender : Int?
    var avatarImage : UIImage?
    var coordinate : CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "SingUp")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(handleImageAvatarTap))
        imageAvatar.isUserInteractionEnabled = true
        imageAvatar.addGestureRecognizer(imageTap)
    }
    
    private let mainScrollView : UIScrollView = UIScrollView()
    private let mainView : UIView = UIView()
    
    let imageAvatar : CustomImageView = {
        let iv = CustomImageView()
        iv.image = Icon.by(imageName: "camera")
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 50
        iv.layer.masksToBounds = true
        
        iv.layer.borderColor = AppColor.lightGray.cgColor
        iv.layer.borderWidth = 1
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "EmailAddress")
        return tf
    }()
    
    let fullNameTextField : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "FullName")
        tf.addTarget(self, action: #selector(fullNameTextFieldChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let genderTextField : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Gender")
        return tf
    }()
    
    let ageTextField : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Age")
        return tf
    }()
    
    let phoneTextField : UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "PhoneNumber")
        return tf
    }()
    
    let addressTextField : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .regular, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Address")
        return tf
    }()
    
    let buttonComplate : BasicButton = {
        let btn = BasicButton()
        btn.title = LanguageManager.shared.localized(string: "Next")
        btn.color = AppColor.homeButton3
        btn.addTarget(self, action: #selector(handleComplateButton(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    
    override func setupView() {
        super.setupView()
        setupMainView()
        setupComponent()
        
    }
    
    private func setupMainView(){
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        mainView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        mainView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        mainView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
    }
    
    private func setupComponent(){
        //icon
        
        let emailIcon = IconView(icon: .androidMail, size: 15, color: AppColor.lightGray)
        let fullNameIcon = IconView(icon: .person, size: 15, color: AppColor.lightGray)
        let genderIcon = IconView(icon: .transgender, size: 15, color: AppColor.lightGray)
        //        let ageIcon = IconView(icon: .calendar, size: 15, color: AppColor.lightGray)
        let phoneIcon = IconView(icon: .androidPhonePortrait, size: 15, color: AppColor.lightGray)
        let addressIcon = IconView(icon: .home, size: 15, color: AppColor.lightGray)
        
        //horizontal line
        
        let emailLine = UIView.horizontalLine()
        let fullNameLine = UIView.horizontalLine()
        let genderLine = UIView.horizontalLine()
        //        let ageLine = UIView.horizontalLine()
        let phoneLine = UIView.horizontalLine()
        let addressLine = UIView.horizontalLine()
        
        //add subView
        mainView.addSubview(imageAvatar)
        mainView.addSubview(emailTextField)
        mainView.addSubview(fullNameTextField)
        mainView.addSubview(genderTextField)
        //        mainView.addSubview(ageTextField)
        mainView.addSubview(phoneTextField)
        mainView.addSubview(addressTextField)
        mainView.addSubview(buttonComplate)
        
        mainView.addSubview(emailIcon)
        mainView.addSubview(emailLine)
        
        mainView.addSubview(fullNameIcon)
        mainView.addSubview(fullNameLine)
        
        mainView.addSubview(genderIcon)
        mainView.addSubview(genderLine)
        
        //        mainView.addSubview(ageIcon)
        //        mainView.addSubview(ageLine)
        //
        mainView.addSubview(phoneIcon)
        mainView.addSubview(phoneLine)
        
        mainView.addSubview(addressIcon)
        mainView.addSubview(addressLine)
        
        emailTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        fullNameTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        genderTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        //        ageTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonComplate.heightAnchor.constraint(equalToConstant: itemSize - 10).isActive = true
        
        mainView.addConstraintWithFormat(format: "V:|-\(margin)-[v0][v1][v2][v3][v4][v5]-\(margin)-[v6]-\(margin)-|", views:imageAvatar, emailTextField, fullNameTextField, phoneTextField, genderTextField, addressTextField, buttonComplate)
        
        imageAvatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageAvatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageAvatar.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: emailIcon, emailTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: fullNameIcon, fullNameTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: genderIcon, genderTextField)
        //        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: ageIcon, ageTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: phoneIcon, phoneTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: addressIcon, addressTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: buttonComplate)
        
        emailIcon.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 0).isActive = true
        fullNameIcon.centerYAnchor.constraint(equalTo: fullNameTextField.centerYAnchor, constant: 0).isActive = true
        genderIcon.centerYAnchor.constraint(equalTo: genderTextField.centerYAnchor, constant: 0).isActive = true
        //        ageIcon.centerYAnchor.constraint(equalTo: ageTextField.centerYAnchor, constant: 0).isActive = true
        phoneIcon.centerYAnchor.constraint(equalTo: phoneTextField.centerYAnchor, constant: 0).isActive = true
        addressIcon.centerYAnchor.constraint(equalTo: addressTextField.centerYAnchor, constant: 0).isActive = true
        
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: emailLine)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: fullNameLine)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: genderLine)
        //        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: ageLine)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: phoneLine)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: addressLine)
        
        emailLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        fullNameLine.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 0).isActive = true
        genderLine.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: 0).isActive = true
        //        ageLine.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 0).isActive = true
        addressLine.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 0).isActive = true
        phoneLine.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 0).isActive = true
        
        //add gender button
        let genderButton = UIButton(type: .custom)
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        genderButton.addTarget(self, action: #selector(handleGenderButton(_:)), for: .touchUpInside)
        genderButton.heightAnchor.constraint(equalToConstant: self.itemSize).isActive = true
        
        mainView.addSubview(genderButton)
        mainView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: genderButton)
        genderButton.centerYAnchor.constraint(equalTo: genderTextField.centerYAnchor, constant: 0).isActive = true
        
    }
    
    func handleComplateButton(_ sender : UIButton){
        self.loadingView.show()
        validate { (validateError) in
            self.loadingView.close()
            if validateError != nil{
                let alert = UIAlertController(title: "", message: validateError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.userInfo?["email"] = self.emailTextField.text
                self.userInfo?["name"] = self.fullNameTextField.text
                self.userInfo?["phone"] = self.phoneTextField.text
                self.userInfo?["addressName"] = self.addressTextField.text
                self.userInfo?["lat"] = "\(String(describing: (self.coordinate?.latitude)!))"
                self.userInfo?["lng"] = "\(String(describing: (self.coordinate?.longitude)!))"
                self.userInfo?["gender"] = "\(String(describing: (self.gender)!))"
                let signUpVC_3 = SignUpVC_3()
                signUpVC_3.user = self.userInfo
                signUpVC_3.avatarImage = self.avatarImage
                signUpVC_3.delegate = self.delegate
                self.push(viewController: signUpVC_3)
            }
        }
//        push(viewController: SignUpVC_3())
    }
    
    func handleGenderButton(_ sender : UIButton){
        let maleString = LanguageManager.shared.localized(string: "Male")
        let femaleString = LanguageManager.shared.localized(string: "Female")
        let genderString = LanguageManager.shared.localized(string: "Gender")
        let cancelString = LanguageManager.shared.localized(string: "Cancel")
        let actionSheet = UIAlertController(title: "", message: genderString, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: maleString, style: .default, handler: { (nil) in
            self.gender = 0
            self.genderTextField.text = maleString
        }))
        actionSheet.addAction(UIAlertAction(title: femaleString, style: .default, handler: { (nil) in
            self.gender = 1
            self.genderTextField.text = femaleString
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    //MARK: - handle image
    
    func handleImageAvatarTap(){
        let takePhotoString = LanguageManager.shared.localized(string: "TakePhoto")
        let galleryString = LanguageManager.shared.localized(string: "Gallery")
        let cancelString = LanguageManager.shared.localized(string: "Cancel")
        let selectImage = LanguageManager.shared.localized(string: "SelectImage")
        
        let actionSheet = UIAlertController(title: "", message: selectImage, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: takePhotoString, style: .default, handler: { (nil) in
            self.handleTakePhoto()
        }))
        actionSheet.addAction(UIAlertAction(title: galleryString, style: .default, handler: { (nil) in
            self.handleSelectFromGallery()
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
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
    
    func showImagePickerWith(sourceType : UIImagePickerControllerSourceType)
    {
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
            let imageResized = image.resize(newWidth: 500)
            imageAvatar.image = imageResized
            self.avatarImage = imageResized
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //MARK: - handle keyboard
    
    func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillHide(notification : Notification){
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    //MARK: - Validate
    
    func validate(completion: @escaping ((String?) -> ())){
        
        if let emailError = validateEmail(){
            completion(emailError)
            return
        }
        if let phoneError = validatePhone(){
            completion(phoneError)
            return
        }
        
        if let genderError = validateGender(){
            completion(genderError)
        }
        if let avatarError = validateAvatar(){
            completion(avatarError)
            return
        }
        if let fullNameError = validateFullName(){
            completion(fullNameError)
            return
        }
        validateAddress { (addressError) in
            if addressError != nil{
                completion(addressError)
            }else{
                completion(nil)
            }
        }
    }
    
    private func validateEmail() -> String?{
        if (emailTextField.text?.isEmail)! {
            return nil
        }
        return LanguageManager.shared.localized(string: "InvalidEmailAddress")
    }
    private func validatePhone() -> String?{
        if (phoneTextField.text?.isPhoneNumber)! {
            return nil
        }
        return LanguageManager.shared.localized(string: "InvalidPhoneNumber")
    }
    private func validateGender() -> String?{
        if self.gender == nil {
            return LanguageManager.shared.localized(string: "PleaseEnterYourGender")
        }
        return nil
    }
    func validateAddress(completion:@escaping (String?)->()){
        let invalidString = LanguageManager.shared.localized(string: "AddressNotFound")
        LocationService.locationFor(address: addressTextField.text!) { (coordinate, error) in
            if error != nil{
                completion(invalidString)
            }else{
                self.coordinate = coordinate
                completion(nil)
            }
        }
    }
    private func validateFullName()-> String?{
        
        if (self.fullNameTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! < 2{
            return LanguageManager.shared.localized(string: "PleaseFillInYourFullname")
        }
        return nil
    }
    func validateAvatar() -> String?{
        if self.avatarImage == nil{
            return LanguageManager.shared.localized(string: "Avatar")
        }
        return nil
    }
    func fullNameTextFieldChange(_ sender: UITextField){
        let lenght = sender.text?.characters.count
        let metin = sender.text
        if lenght! > 50{
            let index = metin?.index((metin?.startIndex)!, offsetBy: 11)
            sender.text = sender.text?.substring(to: index!)
        }
    }
    
}
