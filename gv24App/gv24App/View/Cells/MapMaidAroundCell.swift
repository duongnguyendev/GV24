//
//  MapMaidAroundCell.swift
//  gv24App
//
//  Created by dinhphong on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

protocol MapMaidAroundCellDelegate: class {
    func selected(_ maid: MaidProfile?)
}

class MapMaidAroundCell : BaseCollectionCell, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    weak var delegate: MapMaidAroundCellDelegate?
    var maids : [MaidProfile]?{
        didSet{
            if let _ = maids {
                reloadMap()
            }
            
        }
    }
    
    var currentLocation: CLLocationCoordinate2D? {
        didSet{
            if let location = currentLocation {
                self.mapView.animate(toLocation: location)
            }
        }
    }
    lazy var mapView : GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.delegate = self
        return mapView
    }()
    
    override func setupView() {
        super.setupView()
        self.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        mapView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        mapView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    //MARK: - mapview delegate
    func addMarkerFor(user : MaidProfile, at index : String ){
        let marker : GMSMarker = GMSMarker(position: (user.address?.location)!)
        marker.icon = Icon.iconMarker
        marker.title = index
        marker.map = self.mapView
    }
    
    //Show UIView Info Window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let index = Int(marker.title!)
        let window = MarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        window.user = maids?[index!]
        return window
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let index = Int(marker.title!){
            delegate?.selected(maids?[index])
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
}
