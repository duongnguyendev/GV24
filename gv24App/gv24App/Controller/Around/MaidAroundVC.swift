//
//  WordAroundVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import GoogleMaps

@objc protocol FilterDelegate{
    @objc optional func filter(params : Dictionary<String, Any>?)
}

class MaidAroundVC: BaseVC, UISearchBarDelegate, CLLocationManagerDelegate, GMSMapViewDelegate, FilterDelegate {
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    var maids : [MaidProfile]?{
        didSet{
            reloadMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "TitleNearbyWorkers")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        setupLocationManager()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewHandleKeyboard.isHidden = true
    }
    override func setupRightNavButton() {
        let buttonFilter = NavButton(icon: .iosSettingsStrong)
        buttonFilter.addTarget(self, action: #selector(handleButtonFilter(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonFilter)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    lazy var searchBar : UISearchBar = {
        let sB = UISearchBar()
        sB.translatesAutoresizingMaskIntoConstraints = false
        sB.placeholder = LanguageManager.shared.localized(string: "Search")
        sB.delegate = self
        return sB
    }()
    let viewHandleKeyboard : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.3)
        v.isHidden = true
        return v
    }()
    lazy var mapView : GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        return mapView
    }()
    
    
    override func setupView() {
        view.addSubview(searchBar)
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        mapView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        mapView.backgroundColor = AppColor.backButton
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        viewHandleKeyboard.addGestureRecognizer(tap)
        
        self.view.addSubview(viewHandleKeyboard)
        viewHandleKeyboard.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        viewHandleKeyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        viewHandleKeyboard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        viewHandleKeyboard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
    }
    
    //MARK: - setup location manager
    private func setupLocationManager(){
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
                locationManager.startUpdatingLocation()
            }
            else{
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
    
    //MARK: - handle button
    
    func handleButtonFilter(_ sender: UIButton){
        hideKeyboard()
        if UserHelpers.isLogin{
            let filterVC = FilterVC()
            filterVC.delegate = self
            push(viewController: filterVC)
        }else{
            showAlertLogin()
        }

    }
    //MARK: - search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
        let text = searchBar.text!
        LocationService.locationFor(address: text) { (cordinate, error) in
            if error != nil{
                print(error as Any)
            }else{
                self.handle(location: cordinate!)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let location : CLLocationCoordinate2D = (manager.location?.coordinate)!
        handle(location: location)
        
    }
    
    func handle(location : CLLocationCoordinate2D){
        self.hideKeyboard()
        self.mapView.animate(toLocation: location)
        self.currentLocation = location
        UserService.shared.getMaidAround(location: location) { (response, error) in
            if error == nil{
                self.maids = response
            }
        }
        
    }
    
    //MARK: - mapview delegate
    
    func addMarkerFor(user : MaidProfile, at index : String ){
        let marker : GMSMarker = GMSMarker(position: (user.address?.location)!)
        marker.icon = Icon.iconMarker
        marker.title = index
        marker.map = self.mapView
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let index = Int(marker.title!)
        let window = MarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        window.user = maids?[index!]
        return window
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if UserHelpers.isLogin{
            if let index = Int(marker.title!){
                let maidProfileVC = MaidProfileVC()
                maidProfileVC.maid = maids?[index]
                self.present(viewController: maidProfileVC)
            }
        }else{
            showAlertLogin()
        }

    }
    func reloadMap(){
        self.mapView.clear()
        var index = 0
        for maid in maids! {
            self.addMarkerFor(user: maid, at: "\(index)")
            index += 1
        }
    }
    
    func showAlertLogin(){
        let loginMes = LanguageManager.shared.localized(string: "PleaseSignInBeforeUsingThisFeature")
        let alert = UIAlertController(title: "", message: loginMes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
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
    
    override func hideKeyboard() {
        self.viewHandleKeyboard.isHidden = true
        super.hideKeyboard()
    }
    func keyboardWillShow(notification : Notification){
        self.viewHandleKeyboard.isHidden = false
    }
}
