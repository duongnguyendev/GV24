//
//  DescTaskView.swift
//  gv24App
//
//  Created by Macbook Solution on 5/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
class DescTaskView: BaseView {
    let margin : CGFloat = 20
    var task: Task?{
        didSet{
            iconType.loadImageurl(link: (task?.info?.work?.image)!)
            labelTitle.text = task?.info?.title
            labelType.text = task?.info?.work?.name
            labelDescTask.text = task?.info?.desc
            moneyView.name = "\((task?.info?.price)!) VND"
            datetimeView.name = Date(isoDateString: (task?.info?.time?.startAt)!).dayMonthYear
            datetimeView.clock = Date(isoDateString: (task?.info?.time?.startAt)!).hourMinute + " - " + Date(isoDateString: (task?.info?.time?.endAt)!).hourMinute
            addressView.name = task?.info?.address?.name
        }
    }
    private let iconType : IconView = {
        let iv = IconView(image: "nau_an", size: 50)
        return iv
    }()
    private let labelTitle : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 17)
        lb.text = "Lau dọn nhà"
        return lb
    }()
    
    private let labelType : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Dọn dẹp nhà cửa"
        lb.textColor = UIColor.gray
        return lb
    }()
    
    private let labelDescTask: UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .justified
        lb.numberOfLines = 3
        lb.text = "Cần 1 bạn nữ dọn phòng sáng ngày thứ 4, sau 9 giờ.Cần 1 bạn nữ dọn phòng sáng ngày thứ 4, sau 9 giờ."
        return lb
    }()
    
    let viewLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 200, green: 199, blue: 204)
        return view
    }()
    
    let moneyView: DescInfoView = {
        let view = DescInfoView()
        view.icon = .socialUsd
        view.name = "500.000 VND"
        return view
    }()
    let viewMoneyLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 200, green: 199, blue: 204)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let datetimeView: DateTimeView = {
        let view = DateTimeView()
        view.icon = .androidAlarmClock
        view.name = "10/10/2017"
        view.clock = "09:00 AM - 12:00 PM"
        return view
    }()
    let viewTimerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 200, green: 199, blue: 204)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let addressView: DescInfoView = {
        let view = DescInfoView()
        view.icon = .androidHome
        view.name = "12 đường 2,P.Bình Thọ,Q.3 ,TP.Hồ Chí Minh"
        return view
    }()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(iconType)
        addSubview(labelTitle)
        addSubview(labelType)
        addSubview(labelDescTask)
        addSubview(viewLine)
        addSubview(moneyView)
        addSubview(viewMoneyLine)
        addSubview(datetimeView)
        addSubview(viewTimerLine)
        addSubview(addressView)
        
        
        iconType.topAnchor.constraint(equalTo: topAnchor, constant: margin/2).isActive = true
        iconType.leftAnchor.constraint(equalTo: leftAnchor, constant: margin/2).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: iconType.topAnchor, constant: margin/2).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin/2).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        
        labelType.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin/2).isActive = true
        labelType.bottomAnchor.constraint(equalTo: iconType.bottomAnchor, constant: -margin/4).isActive = true
        
        self.setupLabelDescTask()
        
        addConstraintWithFormat(format: "H:|[v0]|", views: viewLine)
        viewLine.heightAnchor.constraint(equalToConstant: 1/2).isActive = true
        viewLine.bottomAnchor.constraint(equalTo: labelDescTask.bottomAnchor, constant: 10).isActive = true
        
        addConstraintWithFormat(format: "H:|[v0]|", views: moneyView)
        moneyView.topAnchor.constraint(equalTo: viewLine.bottomAnchor, constant: 0).isActive = true
        moneyView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addConstraintWithFormat(format: "H:|-40-[v0]|", views: viewMoneyLine)
        viewMoneyLine.topAnchor.constraint(equalTo: moneyView.bottomAnchor, constant: 0).isActive = true
        viewMoneyLine.heightAnchor.constraint(equalToConstant: 1/2).isActive = true
        
        addConstraintWithFormat(format: "H:|[v0]|", views: datetimeView)
        datetimeView.topAnchor.constraint(equalTo: viewMoneyLine.bottomAnchor, constant: 0).isActive = true
        datetimeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addConstraintWithFormat(format: "H:|-40-[v0]|", views: viewTimerLine)
        viewTimerLine.topAnchor.constraint(equalTo: datetimeView.bottomAnchor, constant: 0).isActive = true
        viewTimerLine.heightAnchor.constraint(equalToConstant: 1/2).isActive = true
        
        addConstraintWithFormat(format: "H:|[v0]|", views: addressView)
        addressView.topAnchor.constraint(equalTo: viewTimerLine.bottomAnchor, constant: 0).isActive = true
        addressView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLabelDescTask(){
        let size = CGSize(width: self.frame.width - margin - margin, height: 1000)
        let height = String.heightWith(string: labelDescTask.text!, size: size, font: labelDescTask.font!)
        
        labelDescTask.topAnchor.constraint(equalTo: iconType.bottomAnchor, constant: margin/2).isActive = true
        addConstraintWithFormat(format: "H:|-\(margin - 10)-[v0]-\(margin - 10)-|", views: labelDescTask)
        labelDescTask.heightAnchor.constraint(equalToConstant: height + 40).isActive = true
    }
}
