//
//  TaskCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class TaskCell: BaseCollectionCell {
    let margin : CGFloat = 10
    var statusTask: String?{
        didSet{
            labelStatus.text = statusTask
        }
    }
    let iconType : IconView = {
        let iv = IconView(image: "nau_an", size: 50)
        return iv
    }()
    let iconAlarmClock : IconView = {
        let iv = IconView(icon: .androidAlarmClock, size: 20, color: AppColor.backButton)
        return iv
    }()
    let labelTitle : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 17)
        lb.text = "Lau dọn nhà"
        return lb
    }()
    
    let labelStatus : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "JobsForApplications")
        lb.textColor = UIColor.gray
        return lb
    }()
    
    let labelUploadAt : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "23 phút trước"
        lb.textAlignment = .center
        lb.textColor = UIColor.gray
        return lb
    }()
    let labelDate : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "10/10/2017"
        return lb
    }()
    let labelTimes : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "9h00 am - 12h00 am"
        lb.textColor = UIColor.gray
        return lb
    }()
    
    override func setupView() {
        backgroundColor = UIColor.white
        let verticalLine = UIView.verticalLine(height : 10)
        addSubview(iconType)
        addSubview(iconAlarmClock)
        addSubview(labelTitle)
        addSubview(labelStatus)
        addSubview(labelDate)
        addSubview(labelTimes)
        addSubview(labelUploadAt)
        addSubview(verticalLine)
        
        iconType.topAnchor.constraint(equalTo: topAnchor, constant: margin/2).isActive = true
        iconType.leftAnchor.constraint(equalTo: leftAnchor, constant: margin).isActive = true
        
        iconAlarmClock.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        iconAlarmClock.centerXAnchor.constraint(equalTo: iconType.centerXAnchor, constant: 0).isActive = true

        labelTitle.topAnchor.constraint(equalTo: iconType.topAnchor, constant: margin/4).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true

        labelStatus.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin).isActive = true
        labelStatus.bottomAnchor.constraint(equalTo: iconType.bottomAnchor, constant: -margin/4).isActive = true
        addConstraint(NSLayoutConstraint(item: labelStatus, attribute: .width, relatedBy: .equal, toItem: labelUploadAt, attribute: .width, multiplier: 1, constant: 0))
        
        addConstraintWithFormat(format: "H:[v0][v1][v2]|", views: labelStatus, verticalLine, labelUploadAt)
        
        verticalLine.centerYAnchor.constraint(equalTo: labelStatus.centerYAnchor, constant: 0).isActive = true
        
        labelUploadAt.centerYAnchor.constraint(equalTo: labelStatus.centerYAnchor, constant: 0).isActive = true
        
        labelDate.centerYAnchor.constraint(equalTo: iconAlarmClock.centerYAnchor, constant: 0).isActive = true
        labelDate.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin).isActive = true
        labelDate.rightAnchor.constraint(equalTo: verticalLine.leftAnchor, constant: 0).isActive = true
        
        labelTimes.centerYAnchor.constraint(equalTo: iconAlarmClock.centerYAnchor, constant: 0).isActive = true
        labelTimes.leftAnchor.constraint(equalTo: verticalLine.rightAnchor, constant: 0).isActive = true
        labelTimes.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    var task: Task?{
        didSet{
            let date = Date(isoDateString: (task?.info?.time?.startAt)!)
            labelTitle.text = task?.info?.title
            iconType.loadImageurl(link: (task?.info?.work?.image)!)
            labelDate.text = date.dayMonthYear
            labelTimes.text = Date(isoDateString: (task?.info?.time?.startAt)!).hourMinute + " - " + Date(isoDateString: (task?.info?.time?.endAt)!).hourMinute
            labelUploadAt.text = Date(isoDateString: (task?.history?.updateAt)!).periodTime
        }
    }
    
}
