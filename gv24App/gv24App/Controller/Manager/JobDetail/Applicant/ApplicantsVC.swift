//
//  ApplicantsVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ApplicantsVC: BaseVC,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ApplicantControlDelegate{
    var applicants = [Applicant]()
    var delegate: TaskManageDelegate?
    
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
        push(viewController: maidProfileVC)
    }
    func selectedMaid(id: String, maid: MaidProfile) {
        if delegate != nil{
            delegate?.selectedYourApplicants!()
            TaskService.shared.selectedMaid(id: id, maidId: maid.maidId!, completion: { (flag) in
                if flag!{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: nil, message: "Chọn người giúp việc thành công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

}
