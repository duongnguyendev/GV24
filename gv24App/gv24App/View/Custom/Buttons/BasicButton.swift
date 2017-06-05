//
//  BasicButton.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class BasicButton: BaseButton {

    var color : UIColor?{
        didSet{
            self.backgroundColor = color
        }
    }
    var titleCollor : UIColor?{
        didSet{
            self.setTitleColor(titleCollor, for: .normal)
        }
    }
    var title : String?{
        didSet{
            self.setTitle(LanguageManager.shared.localized(string: title!), for: .normal)
        }
    }
    var titleFont : Fonts?{
        didSet{
            self.titleLabel?.font = titleFont
        }
    }
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = Fonts.by(name: .semibold, size: 15)
        self.setTitleColor(AppColor.white, for: .normal)
    }

}
