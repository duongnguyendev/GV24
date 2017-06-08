//
//  RatingStartView.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class RatingStartView: BaseView {
    
    let button1 = StartButton()
    let button2 = StartButton()
    let button3 = StartButton()
    let button4 = StartButton()
    let button5 = StartButton()
    var arrayButton : [StartButton] = [StartButton]()
    
    var point : Double? = 0{
        didSet{
            if point != nil{
                handle(point: point!)
            }
            
        }
    }
    override func setupView() {
        
        arrayButton = [button1, button2, button3, button4, button5]
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(button4)
        addSubview(button5)
        
        button1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        button2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        button3.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        button4.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        button5.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        button1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "H:[v0][v1][v2][v3][v4]", views: button1, button2, button3, button4, button5)
        
    }
    
    func handle(point: Double){
        var currentStart : Int = 0
        var currentPoint = point
        while currentPoint > 0 {
            if currentPoint < 0.3 {
                arrayButton[currentStart].isHalf = true
            }else{
                if currentPoint < 0.7 {
                    arrayButton[currentStart].isHalf = true
                }
                else{
                    arrayButton[currentStart].isSelected = true
                }
            }
            currentStart = currentStart + 1
            currentPoint = currentPoint - 1
        }
    }
}

class StartButton : BaseButton{
    
    var isHalf: Bool?{
        didSet{
            if isHalf == true{
                self.setImage(Icon.by(name: .iosStarHalf, color: AppColor.homeButton1), for: .normal)
            }else{
                
            }
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected == true {
                self.setImage(Icon.by(name: .iosStar, color: AppColor.homeButton1), for: .normal)
            }else{
                self.setImage(Icon.by(name: .iosStarOutline, color: AppColor.homeButton1), for: .normal)
            }
        }
    }
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(Icon.by(name: .iosStarOutline, color: AppColor.homeButton1), for: .normal)
        self.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
