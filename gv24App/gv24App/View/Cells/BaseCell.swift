//
//  BaseCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
    }

}
class BaseTableCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class CellWithTitle: BaseCollectionCell {
    var title : String?{
        didSet{
            titleView.text = title
        }
    }
    private let titleView : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 15)
        return lb
    }()
    override func setupView() {
        addSubview(titleView)
        backgroundColor = UIColor.white
        addConstraintWithFormat(format: "V:|[v0]|", views: titleView)
        addConstraintWithFormat(format: "H:|-20-[v0]|", views: titleView)
    }
}

