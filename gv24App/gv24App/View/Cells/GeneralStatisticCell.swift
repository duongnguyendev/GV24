//
//  GeneralStatisticCell.swift
//  gv24App
//
//  Created by HuyNguyen on 9/11/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit

protocol GeneralStatisticCellDelegate: class {
    func genaralStatic(cell: GeneralStatisticCell)
}

class GeneralStatisticCell: BaseCollectionCell {
    
    weak var delegate: GeneralStatisticCellDelegate?
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.homeButton3
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(genaralStatic(_:)), for: .touchUpInside)
        btn.setTitle("General Statistic", for: .normal)
        return btn
    }()
    
    func genaralStatic(_ sender: UIButton) {
        self.delegate?.genaralStatic(cell: self)
    }
    
    override func setupView() {
        super.setupView()
        self.backgroundColor = .white
        self.contentView.addSubview(button)
        
        contentView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: button)
        contentView.addConstraintWithFormat(format: "V:|[v0]|", views: button)
        
    }
    
}
