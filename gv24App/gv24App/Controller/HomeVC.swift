//
//  HomeVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class HomeVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var currentLanguage = LanguageManager.shared.getCurrentLanguage().languageCode{
        didSet{
            loadTypeOfWork()
        }
    }
    
    var typeOfWorks : [WorkType]?{
        didSet{
            self.collectionViewTypeOfwork.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewTypeOfwork.register(WorkTypeCell.self, forCellWithReuseIdentifier: cellId)
        loadTypeOfWork()
    }
    let backGroundView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bg_app"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentLanguage != LanguageManager.shared.getCurrentLanguage().languageCode{
            currentLanguage = LanguageManager.shared.getCurrentLanguage().languageCode
        }
        self.collectionViewTypeOfwork.reloadData()
        if !UserHelpers.isLogin {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    let aroundButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor = AppColor.homeButton1
        bt.imageName = "quanh_day"
        bt.title = "Giúp việc\nquanh đây"
        bt.addTarget(self, action: #selector(handleButtonAround(_:)), for: .touchUpInside)
        return bt
    }()
    let taskManagerButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  AppColor.homeButton2
        bt.imageName = "quan_ly"
        bt.addTarget(self, action: #selector(handleButtonTaskManagement(_:)), for: .touchUpInside)
        return bt
    }()
    let historyButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  AppColor.homeButton3
        bt.imageName = "lich_su"
        bt.addTarget(self, action: #selector(handleButtonHistory(_:)), for: .touchUpInside)
        return bt
    }()
    let sloganView : HomeBottomView = {
        let v = HomeBottomView()
        return v
    }()
    
    let cellId = "cellId"
    let widthCell = (UIScreen.main.bounds.width) / 4
    
    lazy var collectionViewTypeOfwork: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        //        cv.layer.borderColor = UIColor.clear.cgColor
        //        cv.layer.borderWidth = 4
        return cv
    }()
    
    override func setupView() {
        setupBackGround()
        view.addSubview(collectionViewTypeOfwork)
        view.addSubview(sloganView)
        view.addSubview(aroundButton)
        view.addSubview(taskManagerButton)
        view.addSubview(historyButton)
        
        
        let buttonSize = view.frame.size.width / 3
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: sloganView)
        view.addConstraintWithFormat(format: "V:[v0(\(buttonSize))]|", views: sloganView)
        
        view.addConstraintWithFormat(format: "H:|[v0(\(buttonSize))][v1(\(buttonSize))][v2]|", views: aroundButton, taskManagerButton, historyButton)
        
        aroundButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        taskManagerButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        historyButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        
        aroundButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        taskManagerButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        historyButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        
        
        let collectionHeight = (UIScreen.main.bounds.width) / 2 * 1.2
        collectionViewTypeOfwork.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewTypeOfwork)
        collectionViewTypeOfwork.heightAnchor.constraint(equalToConstant: collectionHeight).isActive = true
        
    }
    
    override func setupRightNavButton() {
        let buttonMore = NavButton(icon: .more)
        buttonMore.addTarget(self, action: #selector(handleButtonMore(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonMore)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    
    func setupBackGround(){
        view.addSubview(backGroundView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: backGroundView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: backGroundView)
    }
    
    //MARK: - load work type
    
    func loadTypeOfWork(){
        self.loadingView.show()
        TaskService.shared.getWorkTypes { (workTypes, error) in
            self.loadingView.close()
            if error == nil{
                Constant.workTypes = workTypes
                self.typeOfWorks = Constant.workTypes
            }else{
                
            }
        }
    }
    
    //MARK: - Handle button
    func handleButtonMore(_ sender : UIButton) {
        // MARK: - Team lead edited it
        push(viewController: MoreVC())
//        present(viewController: moreVC)
    }
    
    func handleButtonAround(_ sender : UIButton) {
        // MARK: - Team lead edited it
        push(viewController: MaidAroundVC())
        //present(viewController: MaidAroundVC())
    }
    func handleButtonTaskManagement(_ sender : UIButton) {
        // MARK: - Team lead edited it
        push(viewController: TaskManagementVC())
        //present(viewController: TaskManagementVC())
    }
    func handleButtonHistory(_ sender : UIButton) {
        // MARK: - Team lead edited it
        push(viewController: HistoryVC())
        //present(viewController: HistoryVC())
    }
    
    //MARK: - collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeOfWorks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WorkTypeCell
        cell.title = typeOfWorks?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightCell = widthCell * 1.2

        if indexPath.item == 0{
            return CGSize(width: widthCell * 2 , height: heightCell)
        }
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quickPostVC = QuickPostVC()
        quickPostVC.workType = typeOfWorks?[indexPath.item]
        self.push(viewController: quickPostVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //MARK: - localize
    override func localized(){
        title = LanguageManager.shared.localized(string: "Home")
        aroundButton.title = "NearbyWorkers"
        historyButton.title = "WorkHistory"
        taskManagerButton.title = "WorkManagement"
        sloganView.slogan = "TrustQuality"
    }
}
