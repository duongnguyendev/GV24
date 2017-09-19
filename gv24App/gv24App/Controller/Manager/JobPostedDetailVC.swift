//
//  JobPostedDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
@objc protocol TaskManageDelegate {
    @objc optional func chooseMaid()
    @objc optional func checkInMaid()
    
}
class JobPostedDetailVC: JobDetailVC, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedMaid : MaidProfile?  {
        didSet {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    var data = [Applicant](){
        didSet{
            collectionApplicant.reloadData()
        }
    }
    
    var controllerToDismiss: BaseVC?
    var collecionviewCell = SelectApplicantCell()
    var task = Task()
    weak var delegate: TaskManageDelegate?
    
    var collectionApplicant : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.bounces = true
        cv.isDirectionalLockEnabled = true
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.allowsMultipleSelection = true
        
        return cv
    }()
    var selectApplicantCell = "selectApplicantCell"
    
    
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.homeButton1
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.title = LanguageManager.shared.localized(string: "DeleteWork")
        button.sizeImage = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionApplicant.dataSource = self
        collectionApplicant.delegate = self
        
        collectionApplicant.register(SelectApplicantCell.self, forCellWithReuseIdentifier: selectApplicantCell)
        title = LanguageManager.shared.localized(string: "PostedWork")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = task
        //self.appListButton.status = "\((task.stakeholder?.request?.count)!)"
        
    }
    
    override func setupRightNavButton() {
        super.setupRightNavButton()
        
        let button = UIBarButtonItem.init(title: "Choose", style: .done, target: self, action: #selector(handleButtonChoose(_:)))
        button.tintColor = AppColor.backButton
        self.navigationItem.setRightBarButton(button, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func setupView() {
        super.setupView()
        
        deleteButton.color = AppColor.white
        UIButton.corneRadiusDelete(bt: deleteButton)
        mainScrollView.addSubview(collectionApplicant)
        mainScrollView.addSubview(deleteButton)
        
        let views = ["deleteButton": self.deleteButton, "contentView": self.contentView, "collectionApplicant": self.collectionApplicant]
        
        mainScrollView.removeConstraint(self.contentViewTopConstraint)
        
        mainScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[collectionApplicant(124)]-[contentView]-20-[deleteButton(45)]", options: [], metrics: nil, views: views))
        mainScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[collectionApplicant]-16-|", options: [], metrics: nil, views: views))
        mainScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[deleteButton]-16-|", options: [], metrics: nil, views: views))
    }
    
    func handleRemoveTask(_ sender: UIButton){
        self.showAlertWith(task: task)
        print("Handle Remove Task")
    }
    
    func loadApplicant() {
        self.loadingView.show()
        guard let id = task.id else {return}
        TaskManageService.shared.fetchApplicants(id: id) { (applicants, error) in
            if error == nil{
                guard let app = applicants else {return}
                self.loadingView.close()
                //                let applicantVC = ApplicantsVC()
                //                applicantVC.delegate = self.delegate
                //                applicantVC.applicants = app
                self.data = app
                
                self.collectionApplicant.reloadData()
                print("data in: \(self.data)")
            }else{
                
            }
        }
    }
    
    func handleAppListTask(_ sender: UIButton){
        self.loadingView.show()
        guard let id = task.id else {return}
        TaskManageService.shared.fetchApplicants(id: id) { (applicants, error) in
            if error == nil{
                self.loadingView.close()
                let applicantVC = ApplicantsVC()
                applicantVC.delegate = self.delegate
                applicantVC.applicants = applicants!
                self.push(viewController: applicantVC)
            } else {
                
            }
        }
    }
    
    func handleButtonChoose(_ sender: UIButton) {
        guard let id = data[0].id else {return}
        guard let maid = selectedMaid else {return}
        self.selectedMaid(id: id, maid: maid)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SelectApplicantCell = collectionView.dequeueReusableCell(withReuseIdentifier: selectApplicantCell, for: indexPath) as! SelectApplicantCell
        cell.request = data[0].request?[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 88, height: 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = data[0].request?.count else { return 0 }
        return count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        self.selectMaid(indexPath: indexPath)
        
        guard let myCell = cell as? SelectApplicantCell else { return }
        self.selectedMaid = myCell.request?.madid
    }
    
    private func selectMaid(indexPath: IndexPath) {
        let indexPaths = self.collectionApplicant.indexPathsForVisibleItems
        
        for index in indexPaths {
            let cell = collectionApplicant.cellForItem(at: index)
            if index.row == indexPath.row {
                cell?.backgroundColor = AppColor.backButton
                cell?.layer.cornerRadius = 10.0
                cell?.layer.masksToBounds = true
                cell?.layer.borderColor = AppColor.white.cgColor
            } else {
                cell?.backgroundColor = AppColor.white
            }
        }
    }
    
    func selectedMaid(id: String, maid: MaidProfile) {
        self.loadingView.show()
        TaskService.shared.selectedMaid(id: id, maidId: maid.maidId!, completion: { [weak self] (flag, error) in
            self?.loadingView.close()
            if flag!{
                self?.showAlertWith(message: LanguageManager.shared.localized(string: "CongratsYouHaveYourRightPerson")!, completion: {
                    self?.goBack()
                })
            }else{
                var message = LanguageManager.shared.localized(string: "FailedToChooseYourRightPerson")
                if (error == "SCHEDULE_DUPLICATED") {
                    message = LanguageManager.shared.localized(string: "SCHEDULE_DUPLICATED")
                } else if (error == "DATA_NOT_EXIST") {
                    message = LanguageManager.shared.localized(string: "DATA_NOT_EXIST")
                }
                self?.showAlertWith(message: message!, completion: {})
            }
        })
    }
    
    //Mark: - Show Alert Message
    func showAlertWith(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


extension JobPostedDetailVC: SelectApplicantCellDelegate {
    
    func didSelectItemAtIndex(cell: SelectApplicantCell, img: UIImageView) {
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = cell.request?.madid
        self.push(viewController: maidProfileVC)
    }
}
