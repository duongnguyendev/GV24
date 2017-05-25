//
//  WordAroundVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import GoogleMaps

class MaidAroundVC: BaseVC, UISearchBarDelegate, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    lazy var geocoder = CLGeocoder()
    var maids : [MaidProfile]?{
        didSet{
            var index = 0
            for maid in maids! {
                self.addMarkerFor(user: maid, at: "\(index)")
                index += 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "Around")
        setupLocationManager()
    }
    
    override func setupRightNavButton() {
        let buttonFilter = UIButton(type: .custom)
        buttonFilter.addTarget(self, action: #selector(handleButtonFilter(_:)), for: .touchUpInside)
        buttonFilter.setBackgroundImage(Icon.by(name: .iosSettingsStrong, color: AppColor.backButton), for: .normal)
        buttonFilter.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let btn = UIBarButtonItem(customView: buttonFilter)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    lazy var searchBar : UISearchBar = {
        let sB = UISearchBar()
        sB.translatesAutoresizingMaskIntoConstraints = false
        sB.placeholder = "Search"
        sB.delegate = self
        return sB
    }()
    lazy var mapView : GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 12.0)
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
        push(viewController: FilterVC())
    }
    //MARK: - search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
        let text = searchBar.text!
        geocoder.geocodeAddressString(text) { (placeMarks, error) in
            if error == nil{
                if (placeMarks?.count)! > 0{
                    let firstLocation = placeMarks?.first?.location
                    self.handle(location: (firstLocation?.coordinate)!)
                }
                else{
                    print("không tìm thấy địa điểm")
                }
            }else{
                print(error?.localizedDescription as Any)
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
        let window = MarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 90))
        window.user = maids?[index!]
        return window
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let index = Int(marker.title!){
            let maidProfileVC = MaidProfileVC()
            maidProfileVC.maid = maids?[index]
            self.push(viewController: maidProfileVC)
        }
    }
}
