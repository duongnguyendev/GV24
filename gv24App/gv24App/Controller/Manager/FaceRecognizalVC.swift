//
//  FaceRecognizalVC.swift
//  gv24App
//
//  Created by dinhphong on 9/11/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileVision
import GTProgressBar

class FaceRecognizalVC: BaseVC {
    
    var faceGMVDetector: GMVDetector!
    
    let avatarMaidImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "face"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let avatarPhotoImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "face"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    
    lazy var resultFaceButton: CustomFaceButton = {
        let btn = CustomFaceButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.delegate = self
        return btn
    }()

    let progressBar: GTProgressBar = {
        let progressBar = GTProgressBar(frame: .zero)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.barBorderColor = .red
        progressBar.barFillColor = .red
        progressBar.barBackgroundColor = .clear
        progressBar.progress = 0.1
        progressBar.font = Fonts.by(name: .light, size: 14)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 0
        progressBar.labelPositionInt = 3
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options: [AnyHashable: Any] =
            [GMVDetectorFaceLandmarkType: GMVDetectorFaceLandmark.all.rawValue,
             GMVDetectorFaceClassificationType: GMVDetectorFaceClassification.all.rawValue,
             GMVDetectorFaceMinSize: 0.3,
             GMVDetectorFaceTrackingEnabled: false
        ]
        faceGMVDetector = GMVDetector(ofType: GMVDetectorTypeFace, options: options)
        
        handleFaceDetect(avatarMaidImage)
        handleFaceDetect(avatarPhotoImage)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        resultFaceButton.layer.cornerRadius = 40
        /*resultFaceButton.layer.shadowOpacity = 0.35
        resultFaceButton.layer.shadowRadius = 2
        resultFaceButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        resultFaceButton.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 40).cgPath
        resultFaceButton.layer.masksToBounds = true*/
    }
    
    override func setupView() {
        self.view.addSubview(avatarMaidImage)
        self.view.addSubview(avatarPhotoImage)
        self.view.addSubview(resultFaceButton)
        self.view.addSubview(progressBar)
        
        avatarMaidImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        avatarMaidImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        avatarPhotoImage.topAnchor.constraint(equalTo: avatarMaidImage.topAnchor, constant: 0).isActive = true
        avatarPhotoImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        resultFaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultFaceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: progressBar)
        progressBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: resultFaceButton.topAnchor, constant: -20).isActive = true
    }
    
    func handleFaceDetect(_ faceImageView: UIImageView){
        let resizeImage = faceImageView.image?.resizeImage(targetSize: CGSize(width: 120, height: 120))
        let faces = self.faceGMVDetector.features(in: resizeImage, options: nil) as? [GMVFaceFeature]
        
        for face in faces! {
            // face
            let rect = face.bounds
            DrawingUtility.addRectangle(rect, to: faceImageView, with: .red)
            
            // mouth
            if face.hasMouthPosition {
                let point = face.bottomMouthPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .green, withRadius: 2)
            }
            if face.hasMouthPosition {
                let point = face.mouthPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .green, withRadius: 2)
            }
            if face.hasRightMouthPosition {
                let point = face.rightMouthPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .green, withRadius: 2)
            }
            if face.hasLeftMouthPosition {
                let point = face.leftMouthPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .green, withRadius: 2)
            }
            
            // nose
            if face.hasNoseBasePosition {
                let point = face.noseBasePosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .darkGray, withRadius: 4)
            }
            
            // eyes
            if face.hasLeftEyePosition {
                let point = face.leftEyePosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .blue, withRadius: 4)
            }
            
            if face.hasRightEyePosition {
                let point = face.rightEyePosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .blue, withRadius: 4)
            }
            
            // ears
            if face.hasLeftEarPosition {
                let point = face.leftEarPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .purple, withRadius: 4)
            }
            
            if face.hasRightEarPosition {
                let point = face.rightEarPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .purple, withRadius: 4)
            }
            
            // cheeks
            if face.hasLeftCheekPosition {
                let point = face.leftCheekPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .magenta, withRadius: 4)
            }
            
            if face.hasRightCheekPosition {
                let point = face.rightCheekPosition
                DrawingUtility.addCircle(at: point, to: faceImageView, with: .magenta, withRadius: 4)
            }
            
            // smile
            /*if face.hasSmilingProbability && face.smilingProbability > 0.4 {
                let text = String(format: "smiling %0.2f", face.smilingProbability)
                let rect = CGRect(x: face.bounds.minX, y: face.bounds.maxY + 10, width: faceImageView.frame.size.width, height: 30)
                DrawingUtility.addTextLabel(text, at: rect, to: faceImageView, with: .green)
            }*/
        }

    }
    
}
extension FaceRecognizalVC: FaceButtonDelegate {
    func handleRun(_ btnFace: CustomFaceButton) {
        btnFace.type = .success
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2.0) {
                self.avatarMaidImage.frame = CGRect(x: self.view.bounds.size.width / 2 - self.avatarMaidImage.frame.size.width / 2, y: self.view.bounds.size.height / 2 - self.avatarMaidImage.frame.size.height / 2, width: self.avatarMaidImage.frame.width, height: self.avatarMaidImage.frame.height)
            }
            UIView.animate(withDuration: 2.0) {
                self.avatarPhotoImage.frame = CGRect(x: self.view.bounds.size.width / 2 - self.avatarPhotoImage.frame.size.width / 2, y: self.view.bounds.size.height / 2 - self.avatarPhotoImage.frame.size.height / 2, width: self.avatarPhotoImage.frame.width, height: self.avatarPhotoImage.frame.height)
            }
            self.avatarMaidImage.alpha = 0.5
            self.avatarPhotoImage.alpha = 0.5
        }
        print("Handle Button Run")
    }
    
    func handleSuccess(_ btnFace: CustomFaceButton) {
        btnFace.type = .failure
        print("Handle Button Success")
        
        progressBar.animateTo(progress: 1.0)
    }
    
    func handleFailure(_ btnFace: CustomFaceButton) {
        btnFace.type = .run
        print("Handle Button Failure")
    }
}
