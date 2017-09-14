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
    
    
    let lableTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Nguyen Tuan Huy"
        lb.textColor = AppColor.white
        return lb
    
    }()
    
    let lbInfor: UILabel = {
        let lb = UILabel()
        lb.text = "Quick look for maid now"
        lb.textColor = AppColor.white
        return lb
    }()
    
    
    func corner(img: UIImageView) {
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        img.layer.borderColor = AppColor.white.cgColor
        img.layer.borderWidth = 2
    }
    
    lazy var imageView: CustomImageView = {
        let img = CustomImageView()
        let user = UserHelpers.currentUser
        if let imageUrl = user?.avatarUrl{
            img.loadImageUsingUrlString(urlString: imageUrl)
        }
        return img
    }()
    
    let imageProfile: UIButton = {
        let img = UIButton()
        img.addTarget(self, action: #selector(handleButtonMore(_:)), for: .touchUpInside)
        return img
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        if currentLanguage != LanguageManager.shared.getCurrentLanguage().languageCode{
            currentLanguage = LanguageManager.shared.getCurrentLanguage().languageCode
        }
        self.collectionViewTypeOfwork.reloadData()
        if !UserHelpers.isLogin {
            self.dismiss(animated: false, completion: nil)
        }
        corner(img: imageView)
    }
    
    let aroundButton : BasicButton = {
        let bt = BasicButton()
        bt.backgroundColor = AppColor.homeButton1
        bt.title = "Giúp việc nquanh đây"
        bt.addTarget(self, action: #selector(handleButtonAround(_:)), for: .touchUpInside)
        return bt
    }()
    let taskManagerButton : BasicButton = {
        let bt = BasicButton()
        bt.backgroundColor =  AppColor.homeButton2
        bt.addTarget(self, action: #selector(handleButtonTaskManagement(_:)), for: .touchUpInside)
        return bt
    }()
    let historyButton : BasicButton = {
        let bt = BasicButton()
        bt.backgroundColor =  AppColor.homeButton3
        bt.addTarget(self, action: #selector(handleButtonHistory(_:)), for: .touchUpInside)
        return bt
    }()
    let sloganView : HomeBottomView = {
        let v = HomeBottomView()
        return v
    }()
    
    let viewRadian: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.rgbAlpha(red: 38, green: 38, blue: 38, alpha: 0.8)
        return v
    }()
    
    func cornerButton(bt: UIButton) {
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
        bt.layer.borderWidth = 2
        bt.layer.borderColor = AppColor.white.cgColor
    }
    
    let cellId = "cellId"
    let widthCell = (UIScreen.main.bounds.width) / 4 - 10
    
    lazy var collectionViewTypeOfwork: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupView() {
        setupBackGround()
        view.addSubview(viewRadian)
        view.addSubview(imageView)
        view.addSubview(lbInfor)
        view.addSubview(collectionViewTypeOfwork)
        view.addSubview(aroundButton)
        view.addSubview(taskManagerButton)
        view.addSubview(historyButton)
        view.addSubview(lableTitle)
        view.addSubview(imageProfile)
        
        
        cornerButton(bt: aroundButton)
        cornerButton(bt: taskManagerButton)
        cornerButton(bt: historyButton)
        
        viewRadian.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        viewRadian.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        viewRadian.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        viewRadian.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: viewRadian)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: viewRadian)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.addConstraintWithFormat(format: "H:[v0]", views: imageView)
        corner(img: imageView)
        
        imageProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        imageProfile.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        imageProfile.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageProfile.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addConstraintWithFormat(format: "H:[v0]", views: imageProfile)
        
        
        lbInfor.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lbInfor.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 10).isActive = true
        view.addConstraintWithFormat(format: "V:[v0]", views: lbInfor)
        
        
        lableTitle.centerYAnchor.constraint(equalTo: imageProfile.centerYAnchor, constant: 0).isActive = true
        lableTitle.rightAnchor.constraint(equalTo: imageProfile.leftAnchor, constant: -20).isActive = true
        view.addConstraintWithFormat(format: "H:[v0]", views: lableTitle)
        
        
        let collectionHeight = (UIScreen.main.bounds.width) / 2
        collectionViewTypeOfwork.topAnchor.constraint(equalTo: lbInfor.bottomAnchor, constant: 16).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewTypeOfwork)
        collectionViewTypeOfwork.heightAnchor.constraint(equalToConstant: collectionHeight).isActive = true
        
        view.addConstraintWithFormat(format: "V:[v0(64)]-20-[v1(64)]-20-[v2(64)]-30-|", views: aroundButton,taskManagerButton,historyButton)
        
        
        aroundButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        aroundButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true

        
        taskManagerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        taskManagerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true

        
        historyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        historyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true


        
        
    }
    
//    override func setupRightNavButton() {
//        let buttonMore = NavButton(icon: .more)
//        buttonMore.addTarget(self, action: #selector(handleButtonMore(_:)), for: .touchUpInside)
//        let btn = UIBarButtonItem(customView: buttonMore)
//        self.navigationItem.rightBarButtonItem = btn
//    }
//
//    
    
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
        //push(viewController: MoreVC())
        presentLogout(viewController: MoreVC())

    }
    
    func handleButtonAround(_ sender : UIButton) {
        // MARK: - Team lead edited it
        push(viewController: MaidAroundViewController())
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
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.rgbAlpha(red: 130, green: 130, blue: 130, alpha: 0.6)
        cell.layer.masksToBounds = true
        cell.layer.borderColor = AppColor.white.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quickPostVC = QuickPostVC()
        quickPostVC.workType = typeOfWorks?[indexPath.item]
        self.push(viewController: quickPostVC)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let remainingWidth = UIScreen.main.bounds.size.width - 10
        let lineWidth : CGFloat = 4.0
        let width = (remainingWidth - (3 * lineWidth)) / 4
        if indexPath.item == 0 {
            let firstItemWidth = (remainingWidth - ((width * 2) + (lineWidth * 2)))
            return CGSize(width: firstItemWidth, height: width)
        }else{
            return CGSize(width: width, height: width)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
    
    //MARK: - localize
    override func localized(){
        title = LanguageManager.shared.localized(string: "Home")
        aroundButton.title = "NearbyWorkers"
        historyButton.title = "WorkHistory"
        taskManagerButton.title = "WorkManagement"
        sloganView.slogan = "TrustQuality"
        self.lableTitle.text = UserHelpers.currentUser?.name

        lbInfor.text = LanguageManager.shared.localized(string: "Postyourworkhere")
    }
}



