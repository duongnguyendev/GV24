//
//  UpdateProfileVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/8/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class UpdateProfileVC: SignUpVC_2 {

    var user : User?{
        didSet{
//            imageAvatar.loadImageUsingUrlString(urlString: (user?.avatarUrl)!)
            imageAvatar.loadImageurl(link: (user?.avatarUrl)!)
            emailTextField.text = user?.email
            addressTextField.text = user?.address?.name
            fullNameTextField.text = user?.name
            phoneTextField.text = user?.phone
            self.gender = user?.gender
            if user?.gender == 0{
                
                genderTextField.text = "Nam"
            }else{
                genderTextField.text = "Nữ"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = UserHelpers.currentUser
        emailTextField.isUserInteractionEnabled = false
    }
    
    override func handleComplateButton(_ sender: UIButton) {
        activity.startAnimating()
        buttonComplate.isUserInteractionEnabled = false
        validate { (validateError) in
            if validateError != nil{
                self.activity.stopAnimating()
                self.buttonComplate.isUserInteractionEnabled = true
                let alert = UIAlertController(title: "", message: validateError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.handleUpdate()
            }
        }
    }
    
    func handleUpdate(){
        self.userInfo = Dictionary<String, String>()
        self.userInfo?["name"] = self.fullNameTextField.text
        self.userInfo?["phone"] = self.phoneTextField.text
        self.userInfo?["addressName"] = self.addressTextField.text
        self.userInfo?["lat"] = "\(String(describing: (self.coordinate?.latitude)!))"
        self.userInfo?["lng"] = "\(String(describing: (self.coordinate?.longitude)!))"
        self.userInfo?["gender"] = "\(String(describing: (self.gender)!))"
        UserService.shared.updateProfile(info: self.userInfo!, avatar: self.avatarImage) { (userUpdate, error) in
            self.activity.stopAnimating()
            self.buttonComplate.isUserInteractionEnabled = true
            if error == nil{
                UserHelpers.save(user: userUpdate!, token: UserHelpers.token)
                let alert = UIAlertController(title: "Cập nhật thông tin thành công", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)

            }else{
                let alert = UIAlertController(title: "Lỗi", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func validateAvatar() -> String? {
        return nil
    }
    
    override func localized() {
        buttonComplate.title = LanguageManager.shared.localized(string: "Update")
        
    }
}
