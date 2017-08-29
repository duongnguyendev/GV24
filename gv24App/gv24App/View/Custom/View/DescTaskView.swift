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
    var preferredHeight: CGFloat {
        var height = CGFloat(250)
        if let description = self.task?.info?.desc {
            let size = CGSize(width: self.bounds.width - margin*2, height: 1000)
            height += String.heightWith(string: description, size: size, font: labelDescTask.font)
            height += 5
        }
        return height
    }
    let margin : CGFloat = 20
    var task: Task?{
        didSet{
            guard let info = task?.info, let work = info.work else {
                return
            }
            
            if let image = work.image {
                iconType.loadImageurl(link: image)
            }
            labelTitle.text = info.title
            labelType.text = work.name
            if let description = info.desc {
                let size = CGSize(width: self.bounds.width - margin*2, height: 1000)
                let height = String.heightWith(string: description, size: size, font: labelDescTask.font) + 5
                descriptionHeightConstraint?.constant = height
            } else {
                descriptionHeightConstraint?.constant = 0
            }
            labelDescTask.text = info.desc
            if let showTool = info.tool, showTool {
                bringSuplierHeightConstraint?.constant = 16
            } else {
                bringSuplierHeightConstraint?.constant = 0
            }
            if task?.info?.package?.id == "000000000000000000000002" {
                moneyView.name = LanguageManager.shared.localized(string: "PackageTypeText")
            } else {
                moneyView.name = "\(String.numberDecimalString(number: (task?.info?.price)!)) VND"
            }
            datetimeView.name = Date(isoDateString: (task?.info?.time?.startAt)!).dayMonthYear
            datetimeView.clock = Date(isoDateString: (task?.info?.time?.startAt)!).hourMinute + " - " + Date(isoDateString: (task?.info?.time?.endAt)!).hourMinute
            addressView.name = task?.info?.address?.name
            
            self.setNeedsLayout()
        }
    }
    private let iconType : IconView = {
        let iv = IconView(image: "nau_an", size: 50)
        return iv
    }()
    let labelTitle : UILabel = {
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
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
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
    
    let bringSupplierLabel: UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.text = LanguageManager.shared.localized(string: "task.bringSuplier")
        lb.textColor = AppColor.homeButton2
        return lb
    }()
    
    var bringSuplierHeightConstraint: NSLayoutConstraint?
    var descriptionHeightConstraint: NSLayoutConstraint?
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(iconType)
        addSubview(labelTitle)
        addSubview(labelType)
        addSubview(labelDescTask)
        addSubview(bringSupplierLabel)
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
        labelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin/2).isActive = true
        
        labelType.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin/2).isActive = true
        labelType.bottomAnchor.constraint(equalTo: iconType.bottomAnchor, constant: -margin/4).isActive = true
        
        self.setupLabelDescTask()
        self.setupLabelBringSupplier()
        
        addConstraintWithFormat(format: "H:|[v0]|", views: viewLine)
        viewLine.heightAnchor.constraint(equalToConstant: 1/2).isActive = true
        viewLine.bottomAnchor.constraint(equalTo: bringSupplierLabel.bottomAnchor, constant: 10).isActive = true
        
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
        descriptionHeightConstraint = labelDescTask.heightAnchor.constraint(equalToConstant: height + 5)
        descriptionHeightConstraint?.isActive = true
    }
    func setupLabelBringSupplier() {
        let height = 16
        bringSupplierLabel.topAnchor.constraint(equalTo: labelDescTask.bottomAnchor, constant: margin/2).isActive = true
        addConstraintWithFormat(format: "H:|-\(margin - 10)-[v0]-\(margin - 10)-|", views: bringSupplierLabel)
        bringSuplierHeightConstraint = bringSupplierLabel.heightAnchor.constraint(equalToConstant: CGFloat(height))
        bringSuplierHeightConstraint?.isActive = true
    }
}
