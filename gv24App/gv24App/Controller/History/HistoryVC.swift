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
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        collectionControl.register(TaskHistoryControlCell.self, forCellWithReuseIdentifier: taskHistoryCellId)
        collectionControl.register(MaidControlCell.self, forCellWithReuseIdentifier: maidHistoryCellId)
        collectionControl.register(UnpaidWorkControlCell.self, forCellWithReuseIdentifier: unpaidWorkCellId)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingView.show()
        HistoryService.shared.fetchUnpaidWork(completion: { (mWorkUnpaids) in
            if let worksUnpaid = mWorkUnpaids{
                self.labelNumberPaid.isHidden = false
                self.labelNumberPaid.text = "\(worksUnpaid.count)"
                self.loadingView.close()
            }else{
                 self.labelNumberPaid.isHidden = true
                 self.loadingView.close()
            }
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        self.collectionControl.reloadData()
    }
    
    private let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: LanguageManager.shared.localized(string: "CompletedWork"), at: 0, animated: true)
        sc.insertSegment(withTitle: LanguageManager.shared.localized(string: "YourHelpers"), at: 1, animated: true)
        sc.insertSegment(withTitle: LanguageManager.shared.localized(string: "UnpaidWork"), at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.tintColor = AppColor.backButton
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return sc
    }()
    private let labelNumberPaid : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        lb.isHidden = true
        lb.backgroundColor = UIColor.red
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        lb.textAlignment = .center
        lb.text = "2"
        return lb
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
        btn.setTitle("--/--/--/", for: .normal)
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
        view.addSubview(labelNumberPaid)
        
        view.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        
        labelNumberPaid.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        labelNumberPaid.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
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
        self.collectionControl.isUserInteractionEnabled = false
        HistoryService.shared.getCommentOwner(taskID: task.id!) { (commentOwner) in
            self.collectionControl.isUserInteractionEnabled = true
            if let _ = commentOwner{
                let preAssesmentVC = PreviewAssesmentVC()
                preAssesmentVC.taskHistory = task
                preAssesmentVC.content = commentOwner?.content
                self.push(viewController: preAssesmentVC)
            }else{
                let assesmentVC = AssesmentVC()
                assesmentVC.taskHistory = task
                self.present(viewController: assesmentVC)
            }
        }
    }
    func handleProfile(maid: MaidHistory) {
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = maid
        push(viewController: maidProfileVC)
    }
    func handleTaskMaid(list: MaidHistory) {
        let taskMaidVC = ListTaskMaidVC()
        taskMaidVC.id = list.userId
        push(viewController: taskMaidVC)
    }
    func selectedTaskUnpaid(work: WorkUnpaid) {
        let paymentVC = PaymentVC()
        paymentVC.taskProgress = work.task
        paymentVC.workSuccess = work
        present(viewController: paymentVC)
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
        title = LanguageManager.shared.localized(string: "TitleWorkHistory")
    }
}
