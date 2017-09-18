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
        statusTask = LanguageManager.shared.localized(string: "task.history.status.unpaid")
    }
    var taskUnpaid: TaskUnpaid?{
        didSet{
            labelTitle.text = taskUnpaid?.info?.title
            if let image = taskUnpaid?.info?.work?.image {
                guard let url = URL(string: image) else {
                    return
                }
                iconType.af_setImage(withURL: url, placeholderImage: UIImage(named: "nau_an"))
            }
            if let startAt = taskUnpaid?.info?.time?.startAt, let endAt = taskUnpaid?.info?.time?.endAt {
                labelDate.text = Date(isoDateString: startAt).dayMonthYear
                labelTimes.text = Date(isoDateString: startAt).hourMinute + " - " + Date(isoDateString: endAt).hourMinute
            }
            if let updateAt = taskUnpaid?.history?.updateAt {
                labelUploadAt.text = Date(isoDateString: updateAt).periodTime
            }
        }
    }
    
}
