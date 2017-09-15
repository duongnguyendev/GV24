//
//  MaidAroundViewController.swift
//  gv24App
//
//  Created by dinhphong on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps


class MaidAroundViewController: BaseVC, CLLocationManagerDelegate {
    
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    var currentLocation : CLLocationCoordinate2D?
    
    let maidAroundCellId  = "maidAroundCellId"
    let mapMaidAroundCellId  = "mapMaidAroundCellId"
    
    var maids: [MaidProfile]? {
        didSet{
            DispatchQueue.main.async {
                self.collectionType.reloadData()
            }
        }
    }
    
    let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Workers", at: 0, animated: true)
        sc.insertSegment(withTitle: "Map", at: 1, animated: true)
        sc.selectedSegmentIndex = 0
        sc.tintColor = AppColor.backButton
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    lazy var collectionType : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.seqaratorView
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func setupView() {
        super.setupView()
        view.addSubview(segmentedControl)
        view.addSubview(collectionType)
        
        view.addConstraintWithFormat(format: "V:|-10-[v0(30)]-10-[v1]|", views: segmentedControl, collectionType)
        
        view.addConstraintWithFormat(format: "H:|-\(15)-[v0]-\(15)-|", views: segmentedControl)
        view.addConstraintWithFormat(format: "|[v0]|", views: collectionType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LanguageManager.shared.localized(string: "TitleNearbyWorkers")
        
        collectionType.register(MaidAroundControlCell.self, forCellWithReuseIdentifier: maidAroundCellId)
        collectionType.register(MapMaidAroundCell.self, forCellWithReuseIdentifier: mapMaidAroundCellId)
        
        setupLocationManager()
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    override func setupRightNavButton() {
        let buttonFilter = NavButton(icon: .iosSettingsStrong)
        buttonFilter.addTarget(self, action: #selector(handleButtonFilter(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonFilter)
        self.navigationItem.rightBarButtonItem = btn
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let index = targetContentOffset.pointee.x / view.frame.width
        indexPath.item = Int(index)
        segmentedControl.selectedSegmentIndex = Int(index)
    }
    
    //MARK: - segmented Control
    func segmentedValueChanged(_ sender : UISegmentedControl){
        indexPath.item = segmentedControl.selectedSegmentIndex
        self.collectionType.scrollToItem(at: indexPath, at: .left, animated: true)
    }

    //MARK: - setup location manager
    private func setupLocationManager() {
        
        if (CLLocationManager.locationServicesEnabled()) {
            LocationHelpers.shared.locationManager.delegate = self
            
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
                LocationHelpers.shared.locationManager.startUpdatingLocation()
            } else {
                let alertController = UIAlertController (title: "",
                                                         message: "Cài đặt vị trí", preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: "Settings",
                                                   style: .default) { (_) -> Void in
                                                    guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                                                        return
                                                    }
                                                    if UIApplication.shared.canOpenURL(settingsUrl) {
                                                        UIApplication.shared.openURL(settingsUrl)
                                                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .cancel, handler: {(_) -> Void in
                                                    self.goBack()
                })
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationHelpers.shared.locationManager.stopUpdatingLocation()
        let location : CLLocationCoordinate2D = (manager.location?.coordinate)!
        handle(location: location)
    }
    
    func handle(location : CLLocationCoordinate2D){
        self.currentLocation = location
        UserService.shared.getMaidAround(location: location) { (response, error) in
            if error == nil{
                self.maids = response
            }
        }
    }

    //MARK: - handle button
    func handleButtonFilter(_ sender: UIButton){
        let filterVC = FilterVC()
        filterVC.delegate = self
        push(viewController: filterVC)
    }

    func showAlertLogin(){
        let loginMes = LanguageManager.shared.localized(string: "PleaseSignInBeforeUsingThisFeature")
        let alert = UIAlertController(title: "", message: loginMes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MaidAroundViewController: FilterDelegate {
    func filter(params: Dictionary<String, Any>?) {
        self.loadingView.show()
        UserService.shared.filter(params: params!, location: self.currentLocation!, completion: { (response, error) in
            self.loadingView.close()
            if error == nil{
                self.maids = response
            }else{
                let alert = UIAlertController(title: nil, message: LanguageManager.shared.localized(string: "DATA_NOT_EXIST"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

extension MaidAroundViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: maidAroundCellId, for: indexPath) as! MaidAroundControlCell
            cell.delegate = self
            cell.maids = maids
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapMaidAroundCellId, for: indexPath) as! MapMaidAroundCell
            cell.delegate = self
            cell.maids = maids
            cell.currentLocation = currentLocation
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension MaidAroundViewController: MaidAroundCellDelegate {
    func didSelected(_ maid: MaidProfile?) {
        if UserHelpers.isLogin {
            let maidProfileVC = MaidProfileVC()
            maidProfileVC.maid = maid
            self.push(viewController: maidProfileVC)
        }else {
            showAlertLogin()
            
        }
    }
}

extension MaidAroundViewController : MapMaidAroundCellDelegate {
    func selected(_ maid: MaidProfile?) {
        if UserHelpers.isLogin {
            let maidProfileVC = MaidProfileVC()
            maidProfileVC.maid = maid
            self.push(viewController: maidProfileVC)
        }else {
            showAlertLogin()
        }
    }
}
