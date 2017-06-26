//
//  HistoryVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/16/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class HistoryVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HistoryVCDelegate {
    let maidHistoryCellId = "maidCellId"
    let taskHistoryCellId = "historyCellId"
    let unpaidWorkCellId = "unpaidCellId"
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        title = LanguageManager.shared.localized(string: "WorkHistory")
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        collectionControl.register(TaskHistoryControlCell.self, forCellWithReuseIdentifier: taskHistoryCellId)
        collectionControl.register(MaidControlCell.self, forCellWithReuseIdentifier: maidHistoryCellId)
        collectionControl.register(UnpaidWorkControlCell.self, forCellWithReuseIdentifier: unpaidWorkCellId)
    }
    
    private let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Hoàn thành", at: 0, animated: true)
        sc.insertSegment(withTitle: "Gv đã làm", at: 1, animated: true)
        sc.insertSegment(withTitle: "Công nợ", at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.tintColor = AppColor.backButton
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return sc
    }()
    
    private lazy var collectionControl : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.contentInset.top = 20
        return cv
    }()
    
    private let buttonFrom : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("10/10/2017", for: .normal)
        btn.titleLabel?.font = Fonts.by(name: .light, size: 15)
        btn.setTitleColor(AppColor.backButton, for: .normal)
        btn.addTarget(self, action: #selector(handleFromButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let buttonTo : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("10/10/2017", for: .normal)
        btn.titleLabel?.font = Fonts.by(name: .light, size: 15)
        btn.setTitleColor(AppColor.backButton, for: .normal)
        btn.addTarget(self, action: #selector(handleToButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let labelTo : UILabel = {
        let lb = UILabel()
        lb.text = "đến"
        lb.font = Fonts.by(name: .light, size: 15)
        lb.textAlignment = .center
        return lb
    }()
    
    //MARK: - setup View
    
    override func setupView() {
        super.setupView()
        view.addSubview(segmentedControl)
        view.addSubview(collectionControl)
        view.addSubview(buttonFrom)
        view.addSubview(buttonTo)
        view.addSubview(labelTo)
        
        view.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        
        view.addConstraint(NSLayoutConstraint(item: buttonFrom, attribute: .width, relatedBy: .equal, toItem: buttonTo, attribute: .width, multiplier: 1, constant: 0))
        labelTo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0][v1][v2]|", views: buttonFrom, labelTo, buttonTo)
        
        buttonTo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonFrom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelTo.centerYAnchor.constraint(equalTo: buttonFrom.centerYAnchor, constant: 0).isActive = true
        buttonFrom.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        buttonTo.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        collectionControl.topAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionControl)
        collectionControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let line1 = UIView.horizontalLine()
        let line2 = UIView.horizontalLine()
        
        view.addSubview(line1)
        view.addSubview(line2)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: line1)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: line2)
        
        line1.topAnchor.constraint(equalTo: buttonFrom.topAnchor, constant: 0).isActive = true
        line2.topAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 0).isActive = true
        
    }
    
    //MARK: - collection view handle
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = HistoryControlCell()
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: taskHistoryCellId, for: indexPath) as! TaskHistoryControlCell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidHistoryCellId, for: indexPath) as! MaidControlCell
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: unpaidWorkCellId, for: indexPath) as! UnpaidWorkControlCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HistoryControlCell
        }
        cell.type = indexPath.item
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - margin - 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        segmentedControl.selectedSegmentIndex = Int(index)
    }
    
    //MARK: - Delegate-
    func selectedTaskHistory(task: Task) {
        HistoryService.shared.getCommentOwner(taskID: (task.stakeholder?.receivced?.maidId)!) { (commentOwner) in
            if let _ = commentOwner{
                let preAssesmentVC = PreviewAssesmentVC()
                preAssesmentVC.taskHistory = task
                self.push(viewController: preAssesmentVC)
            }else{
                let assesmentVC = AssesmentVC()
                assesmentVC.taskHistory = task
                self.push(viewController: assesmentVC)
            }
        }
    }
    func selectedProfile(maid: MaidHistory) {
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = maid
        push(viewController: maidProfileVC)
    }
    func selectedTaskMaid(list: MaidHistory) {
        let taskMaidVC = ListTaskMaidVC()
        taskMaidVC.id = list.userId
        push(viewController: taskMaidVC)
    }
    func selectedTaskUnpaid() {
        let paymentVC = PaymentVC()
        push(viewController: paymentVC)
    }
    //MARK: - segmented Control
    func segmentedValueChanged(_ sender : UISegmentedControl){
        let index = IndexPath(item: sender.selectedSegmentIndex, section: 0)
        self.collectionControl.scrollToItem(at: index, at: .left, animated: true)
    }
    
    //MARK: - handle button
    func handleFromButton(_ sender : UIButton){
        print("handleFromButton")
    }
    
    func handleToButton(_ sender : UIButton){
        print("handleToButton")
    }
    
    //Mark-Language
    override func localized() {
        
    }
}
