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
    case success = 2
    case failure = 0
}

protocol FaceButtonDelegate: class {
    func handleSuccess(_ btnFace: CustomFaceButton)
    func handleFailure(_ btnFace: CustomFaceButton)
}

class CustomFaceButton: BaseButton {
    
    var type: ButtonType = .failure {
        didSet{
            switch type {
            case .success:
                updateUI(nil, Icon.by(name: .checkmarkRound, color: AppColor.white), AppColor.successButton)
                break
            case .failure:
                updateUI(nil, Icon.by(name: .closeRound, color: AppColor.white), UIColor.red)
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
        updateUI(nil, Icon.by(name: .checkmarkRound, color: AppColor.white), .red)
        translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(handleFaceButton(_:)), for: .touchUpInside)
    }
    
    func handleFaceButton(_ sender: CustomFaceButton) {
        switch type {
        case .success:
            delegate?.handleSuccess(sender)
            break
        case .failure:
            delegate?.handleFailure(sender)
            break
        }
    }
}
