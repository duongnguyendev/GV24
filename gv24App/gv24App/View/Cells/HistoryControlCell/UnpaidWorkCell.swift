//
//  UnpaidWorkCell.swift
//  gv24App
//
//  Created by Macbook Solution on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class UnpaidWorkCell: TaskCell{
    
    override func setupView() {
        super.setupView()
        statusTask = "Chưa thanh toán"
    }
    var taskUnpaid: TaskUnpaid?{
        didSet{
            labelTitle.text = taskUnpaid?.info?.title
            iconType.loadImageurl(link: (taskUnpaid?.info?.work?.image)!)
            labelDate.text = Date(isoDateString: (taskUnpaid?.info?.time?.startAt)!).dayMonthYear
            labelTimes.text = Date(isoDateString: (taskUnpaid?.info?.time?.startAt)!).hourMinute + " - " + Date(isoDateString: (taskUnpaid?.info?.time?.endAt)!).hourMinute
        }
    }
    
}
