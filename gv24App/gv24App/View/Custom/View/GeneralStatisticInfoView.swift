//
//  GeneralStatisticInfoView.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class GeneralStatisticInfoView: BaseView {

    var generalStatisticData : GeneralStatistic?{
        didSet{
            labelNumberDone.text = "\(String(describing: (generalStatisticData?.numberDone)!))"
            labelNumberTotalCost.text = "\(String(describing: (generalStatisticData?.totalPrice)!)) triệu"
            labelNumberPosted.text = "\(String(describing: (generalStatisticData?.numberPosted)!))"
            labelNumberRuningWork.text = "\(String(describing: (generalStatisticData?.numberRuning)!))"
        }
    }
    
    let backgroudImage : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "circle"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let labelNumberPosted : UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.homeButton1
        lb.textAlignment = .center
        lb.text = "0"
        lb.font = Fonts.by(name: .regular, size: 35)
        if let window = UIApplication.shared.keyWindow{
            if window.frame.size.width == 414{
                lb.font = Fonts.by(name: .regular, size: 50)
            }
        }
        
        return lb
    }()
    let labelNumberRuningWork : UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.homeButton2
        lb.textAlignment = .center
        lb.text = "0"
        lb.font = Fonts.by(name: .regular, size: 35)
        if let window = UIApplication.shared.keyWindow{
            if window.frame.size.width == 414{
                lb.font = Fonts.by(name: .regular, size: 50)
            }
        }
        return lb
    }()
    let labelNumberDone : UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.homeButton3
        lb.textAlignment = .center
        lb.text = "0"
        lb.font = Fonts.by(name: .regular, size: 35)
        if let window = UIApplication.shared.keyWindow{
            if window.frame.size.width == 414{
                lb.font = Fonts.by(name: .regular, size: 50)
            }
        }
        return lb
    }()
    let labelNumberTotalCost : UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.homeButton3
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "0.0 triệu"
        lb.font = Fonts.by(name: .regular, size: 40)
        if let window = UIApplication.shared.keyWindow{
            if window.frame.size.width == 414{
                lb.font = Fonts.by(name: .regular, size: 50)
            }
        }
        return lb
    }()

    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        
        let labelPosted = labelWith(title: "PostedWork", textSize: 17)
        let labelRuningWork = labelWith(title: "WorkInProcess", textSize: 17)
        let labelDone = labelWith(title: "WorkDone", textSize: 17)
        let labelUnit = labelWith(title: "VND", textSize: 22)
        let labelTotalCost = labelWith(title: "TotalExpense", textSize: 20)
        
        addSubview(backgroudImage)
        addSubview(labelTotalCost)
        addSubview(labelUnit)
        addSubview(labelNumberTotalCost)
        addSubview(labelPosted)
        addSubview(labelRuningWork)
        addSubview(labelDone)
        addSubview(labelNumberPosted)
        addSubview(labelNumberRuningWork)
        addSubview(labelNumberDone)
        
        backgroudImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        backgroudImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backgroudImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        addConstraint(NSLayoutConstraint(item: backgroudImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 2/3, constant: 0))
        
        labelNumberTotalCost.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        labelNumberTotalCost.centerYAnchor.constraint(equalTo: backgroudImage.centerYAnchor, constant: 0).isActive = true
        labelTotalCost.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        labelUnit.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        labelTotalCost.bottomAnchor.constraint(equalTo: labelNumberTotalCost.topAnchor, constant: -15).isActive = true
        labelUnit.topAnchor.constraint(equalTo: labelNumberTotalCost.bottomAnchor, constant: 15).isActive = true
        
        
        
        labelNumberPosted.topAnchor.constraint(equalTo: backgroudImage.bottomAnchor, constant: 0).isActive = true
        labelNumberRuningWork.topAnchor.constraint(equalTo: backgroudImage.bottomAnchor, constant: 0).isActive = true
        labelNumberDone.topAnchor.constraint(equalTo: backgroudImage.bottomAnchor, constant: 0).isActive = true
        
        addConstraintWithFormat(format: "V:[v0]-(-10)-[v1]-5-|", views: labelNumberPosted, labelPosted)
        addConstraintWithFormat(format: "V:[v0]-(-10)-[v1]-5-|", views: labelNumberRuningWork, labelRuningWork)
        addConstraintWithFormat(format: "V:[v0]-(-10)-[v1]-5-|", views: labelNumberDone, labelDone)
        
        addConstraint(NSLayoutConstraint(item: labelNumberPosted, attribute: .height, relatedBy: .equal, toItem: labelPosted, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelNumberRuningWork, attribute: .height, relatedBy: .equal, toItem: labelRuningWork, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelNumberDone, attribute: .height, relatedBy: .equal, toItem: labelDone, attribute: .height, multiplier: 1, constant: 0))
        
        
        addConstraintWithFormat(format: "H:|-5-[v0]-10-[v1]-10-[v2]-5-|", views: labelNumberPosted, labelNumberRuningWork, labelNumberDone)
        addConstraintWithFormat(format: "H:|-5-[v0]-10-[v1]-10-[v2]-5-|", views: labelPosted, labelRuningWork, labelDone)
        addConstraint(NSLayoutConstraint(item: labelNumberPosted, attribute: .width, relatedBy: .equal, toItem: labelNumberRuningWork, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelNumberPosted, attribute: .width, relatedBy: .equal, toItem: labelNumberDone, attribute: .width, multiplier: 1, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: labelNumberPosted, attribute: .width, relatedBy: .equal, toItem: labelPosted, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelNumberRuningWork, attribute: .width, relatedBy: .equal, toItem: labelRuningWork, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelNumberDone, attribute: .width, relatedBy: .equal, toItem: labelDone, attribute: .width, multiplier: 1, constant: 0))
        
        let line1 = UIView.verticalLine()
        let line2 = UIView.verticalLine()
        
        addSubview(line1)
        addSubview(line2)
        
        line1.leftAnchor.constraint(equalTo: labelPosted.rightAnchor, constant: 5).isActive = true
        line2.rightAnchor.constraint(equalTo: labelDone.leftAnchor, constant: -5).isActive = true
        
        line1.centerYAnchor.constraint(equalTo: labelPosted.topAnchor, constant: 0).isActive = true
        line2.centerYAnchor.constraint(equalTo: labelPosted.topAnchor, constant: 0).isActive = true
        
//        line1.topAnchor.constraint(equalTo: labelNumberPosted.topAnchor, constant: 30).isActive = true
//        line2.topAnchor.constraint(equalTo: labelNumberPosted.topAnchor, constant: 30).isActive = true
        
        addConstraint(NSLayoutConstraint(item: line1, attribute: .height, relatedBy: .equal, toItem: labelNumberDone, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: line2, attribute: .height, relatedBy: .equal, toItem: labelNumberDone, attribute: .height, multiplier: 1, constant: 0))
    }
    
    private func labelWith(title: String, textSize : CGFloat) -> UILabel{
        var size = textSize
        if let window = UIApplication.shared.keyWindow{
            if window.frame.size.width == 414{
                size = size * 1.3
            }
        }
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        
        label.font = Fonts.by(name: .light, size: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LanguageManager.shared.localized(string: title)
        label.textColor = UIColor.lightGray
        return label
    }

}
