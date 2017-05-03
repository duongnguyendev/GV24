//
//  ViewController.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 4/26/17.
//  Copyright © 2017 HBB. All rights reserved.
//

import UIKit

class ViewController: BaseVC {
    
    @IBOutlet weak var imageTest: UIImageView!
    @IBOutlet weak var labelTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        labelTest.font = Fonts.by(name: .boldItalic, size: 17)
        labelTest.text = LanguageManager.shared.localized(string: "English")
        imageTest.image = Icon.by(name: .androidAdd, collor: UIColor.blue)
        title = "English"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

