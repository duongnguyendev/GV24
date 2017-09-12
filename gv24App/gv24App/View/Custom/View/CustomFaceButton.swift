//
//  CustomFaceButton.swift
//  gv24App
//
//  Created by dinhphong on 9/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit

enum ButtonType: Int {
    case run = 1
    case success = 2
    case failure = 0
}

protocol FaceButtonDelegate: class {
    func handleRun(_ btnFace: CustomFaceButton)
    func handleSuccess(_ btnFace: CustomFaceButton)
    func handleFailure(_ btnFace: CustomFaceButton)
}

class CustomFaceButton: BaseButton {
    
    var type: ButtonType = .run {
        didSet{
            switch type {
            case .run:
                updateUI("Run Face", nil, AppColor.homeButton3)
            case .success:
                updateUI(nil, Icon.by(name: .checkmarkRound, color: AppColor.white), UIColor.rgb(red: 140.0, green: 220.0, blue: 108.0))
            case .failure:
                updateUI(nil, Icon.by(name: .closeRound, color: AppColor.white), UIColor.red)
            default:
                break
            }
        }
    }
    
    func updateUI(_ title: String? = nil, _ icon: UIImage? = nil, _ backgroundColor: UIColor){
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setImage(icon, for: .normal)
    }
    
    weak var delegate: FaceButtonDelegate?

    override func setupView() {
        super.setupView()
        updateUI("Run Face", nil, AppColor.homeButton3)
        translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(handleFaceButton(_:)), for: .touchUpInside)
    }
    
    func handleFaceButton(_ sender: CustomFaceButton) {
        switch type {
        case .run:
            delegate?.handleRun(sender)
        case .success:
            delegate?.handleSuccess(sender)
        case .failure:
            delegate?.handleFailure(sender)
        default:
            break
        }
    }
}
