//
//  UpdateVC.swift
//  gv24App
//
//  Created by dinhphong on 6/21/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class UpdateVC: QuickPostVC, UITextFieldDelegate{
    var task = Task(){
        didSet{
            self.descText = (task.info?.desc)!
        }
    }
    var descText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "WorkDetail")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.titleTextField.text = task.info?.title
        self.addressTextField.text = task.info?.address?.name
        self.checkBoxTool.isSelected = (task.info?.tool)!
        if task.info?.package?.id == "000000000000000000000001"{
            radioButtonMoney.titleView.text = "\((task.info?.price)!)"
            radioButtonMoney.isSelected = true
            radioButtonTime.isSelected = false
        }else{
            radioButtonTime.isSelected = true
            radioButtonMoney.isSelected = false
        }
        self.date = Date(isoDateString: (task.info?.time?.endAt)!)
        self.timeStart = Date(isoDateString: (task.info?.time?.startAt)!)
        self.timeEnd = Date(isoDateString: (task.info?.time?.endAt)!)
        
        if let descText = task.info?.desc {
            self.descText = descText
            self.textViewDescription.text = descText
        }
    }
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(title: LanguageManager.shared.localized(string: "Update")!)
        buttonSend.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        buttonSend.addTarget(self, action: #selector(handleUpdateButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSend)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    override func createCheckBoxes() -> CGFloat{
        let checkboxWidth = (UIScreen.main.bounds.width - 30) / numberCollum
        var checkboxHeight : CGFloat = 0
        let font = Fonts.by(name: .light, size: 15)
        for suggest in (workType?.suggests)!{

            let checkbox = CheckBox()
            checkbox.title = suggest.name
            if (descText.contains(suggest.name!)){
                descText = descText.replacingOccurrences(of: suggest.name! + "\n", with: "")
                checkbox.isSelected = true
            }
            checkbox.widthAnchor.constraint(equalToConstant: checkboxWidth).isActive = true
            view1.addSubview(checkbox)
            chexboxes.append(checkbox)
            let size = CGSize(width: checkboxWidth - 30, height: 1000)
            let height = checkbox.title?.heightWith(size: size, font: font)
            checkbox.addTarget(self, action: #selector(handleCheckbox(_:)), for: .touchUpInside)
            if checkboxHeight < height!{
                checkboxHeight = height!
            }
        }
        self.textViewDescription.text = descText
        
        return checkboxHeight + 10
    }
    
    //MARK: - handle button
    
    
    func handleUpdateButton(_ sender: UIButton){
        self.loadingView.show()
        hideKeyboard()
        validate { (errorString) in
            if errorString == nil{
                self.params["tools"] = self.checkBoxTool.isSelected
                self.params["id"] = self.task.id
                self.params["process"] = self.task.process?.id
                TaskService.shared.updateTask(params: self.params) { (error) in
                    self.loadingView.close()
                    if error == nil{
                        self.showAlertWith(message: LanguageManager.shared.localized(string: "EditedSuccessfully")!, completion: {
                            // MARK: - TEAM LEAD: Fix present to push here
                            for vc in (self.navigationController?.viewControllers ?? []) {
                                if vc is TaskManagementVC {
                                    _ = self.navigationController?.popToViewController(vc, animated: true)
                                    return
                                }
                            }
                            //self.dismiss(animated: true, completion: nil)
                        })
                    }else{
                        self.showAlertWith(message: error!, completion: {})
                    }
                }
            }
            else{
                self.loadingView.close()
                self.showAlertWith(message: errorString!, completion: {})
            }
        }
    }
}
