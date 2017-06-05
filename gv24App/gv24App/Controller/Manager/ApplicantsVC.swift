//
//  ApplicantsVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ApplicantsVC: BaseVC{
    
    private lazy var collectionApplicant : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.isPagingEnabled = true
        cv.contentInset.top = 20
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "ApplicantList")
    }
    override func setupView() {
        super.setupView()
        self.view.addSubview(collectionApplicant)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionApplicant)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionApplicant)
    }
}
