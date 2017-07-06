//
//  CommentCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class CommentCell: BaseCollectionCell {
    var comment : Comment?{
        didSet{
            if comment?.fromUser?.avatarUrl != nil && comment?.fromUser?.avatarUrl != ""{
                avartaImage.loadImageUsingUrlString(urlString: (comment?.fromUser?.avatarUrl)!)
            }else{
                avartaImage.image = UIImage(named: "avatar")
            }
            ratingView.point = comment?.evaluationPoint
            labelName.text = comment?.fromUser?.name
            labelContent.text = comment?.content
            labelTitle.text = comment?.task?.info?.title
            labelDate.text = comment?.createAt?.dayMonthYear
        }
    } 
    let avartaImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()

    let labelName : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .medium, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.text = "Giúp việc A"
        return lb
    }()
    let labelDate : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 11)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.lightGray
        lb.text = "12/03/2016"
        return lb
    }()
    let labelTitle : UILabel = {
        let lb = UILabel()
        lb.text = "Lau dọn phòng khách"
        lb.numberOfLines = 1
        lb.font = Fonts.by(name: .medium, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelContent : UILabel = {
        let lb = UILabel()
        lb.text = "Bạn siêng năng, dọn phòng đúng sạch sẽ gọn gàng, đi làm đúng giờ."
        lb.font = Fonts.by(name: .regular, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    let ratingView = RatingStartView()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(avartaImage)
        addSubview(labelName)
        addSubview(labelDate)
        addSubview(labelTitle)
        addSubview(labelContent)
        addSubview(ratingView)
        
        ratingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        ratingView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        avartaImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        avartaImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        labelName.topAnchor.constraint(equalTo: avartaImage.topAnchor, constant: 5).isActive = true
        labelName.leftAnchor.constraint(equalTo: avartaImage.rightAnchor, constant: 10).isActive = true
        labelName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        labelDate.bottomAnchor.constraint(equalTo: avartaImage.bottomAnchor, constant: -5).isActive = true
        labelDate.leftAnchor.constraint(equalTo: avartaImage.rightAnchor, constant: 10).isActive = true
        
        labelTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        labelTitle.topAnchor.constraint(equalTo: avartaImage.bottomAnchor, constant: 10).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        labelContent.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        labelContent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        labelContent.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 0).isActive = true
    }

}
