//
//  ApplicantsVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ApplicantsVC: BaseVC,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ApplicantControlDelegate {
    var applicants = [Applicant]()
    weak var delegate: TaskManageDelegate?
    var controllerToDismiss: BaseVC?
    
    private lazy var collectionApplicant : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.contentInset.top = 20
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionApplicant.register(ApplicantCell.self, forCellWithReuseIdentifier: applicantCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = LanguageManager.shared.localized(string: "ApplicantList")
    }
    override func setupView() {
        super.setupView()
        self.view.addSubview(collectionApplicant)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionApplicant)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionApplicant)
    }
    var applicantCellId = "applicantCellId"
    //MARK: - collection view handle
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: applicantCellId, for: indexPath) as! ApplicantCell
        cell.request = applicants[0].request?[indexPath.item]
        cell.idTask = applicants[0].id
        cell.delegateApp = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (applicants[0].request?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func selectedProfile(maid: MaidProfile) {
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = maid
        maidProfileVC.selectable = true
        maidProfileVC.delegate = self
        push(viewController: maidProfileVC)
    }
    
    func selectedMaid(id: String, maid: MaidProfile) {
        if delegate != nil{
            TaskService.shared.selectedMaid(id: id, maidId: maid.maidId!, completion: { (flag, error) in
                if flag!{
                    self.showAlertWith(message: LanguageManager.shared.localized(string: "CongratsYouHaveYourRightPerson")!, completion: {
                        self.delegate?.chooseMaid!()
                        self.controllerToDismiss?.goBack()
                        self.dismiss(animated: true, completion: nil)
                    })
                }else{
                    var message = LanguageManager.shared.localized(string: "FailedToChooseYourRightPerson")
                    if (error == "SCHEDULE_DUPLICATED") {
                        message = LanguageManager.shared.localized(string: "SCHEDULE_DUPLICATED")
                    } else if (error == "DATA_NOT_EXIST") {
                        message = LanguageManager.shared.localized(string: "DATA_NOT_EXIST")
                    }
                    self.showAlertWith(message: message!, completion: {})
                }
            })
        }
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

extension ApplicantsVC: MaidProfileVCDelegate {
    func maidProfileVCDidSelected(_ maidProfileVC: MaidProfileVC) {
        guard let maid = maidProfileVC.maid, let id = applicants[0].id else {
            print("WARNING: user behavior is strange. (maid:\(String(describing: maidProfileVC.maid)), id:\(String(describing: applicants[0].id)))")
            return
        }
        controllerToDismiss = maidProfileVC
        selectedMaid(id: id, maid: maid)
    }
}

