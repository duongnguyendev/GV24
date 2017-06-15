//
//  PaymentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class PaymentVC: BaseVC{
    
    lazy var collectionPayment : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        //cv.delegate = self
        //cv.dataSource = self
        cv.isPagingEnabled = true
        cv.contentInset.top = 20
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thanh toán"
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func setupView() {
        super.setupView()
        self.view.addSubview(collectionPayment)
        
        self.view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionPayment)
    }

}
