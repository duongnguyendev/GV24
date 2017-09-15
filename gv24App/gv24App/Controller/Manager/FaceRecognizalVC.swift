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
import SwiftySound


class FaceRecognizalVC: BaseVC {
    
    var faceGMVDetector: GMVDetector!
    var timer: Timer?
    weak var delegate: TaskManageDelegate?
    
    var progressValue: Int = 0 {
        didSet{
            if progressValue > 50 {
                progressBar.loadingColor = .green
                progressLabel.textColor = .green
                resultFaceButton.type = .success
            }else{
                resultFaceButton.type = .failure
            }
            progressLabel.text = "\(progressValue) %"
        }
    }
    
    var value: Int = 60
    
    lazy var avatarMaidImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "face"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var avatarPhotoImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "face"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    
    lazy var resultFaceButton: CustomFaceButton = {
        let btn = CustomFaceButton()
        btn.isHidden = true
        btn.delegate = self
        return btn
    }()
    
    lazy var progressBar: ProgressBar = {
        let progress = ProgressBar()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.heightAnchor.constraint(equalToConstant: 30).isActive = true
        progress.layer.cornerRadius = 15
        progress.layer.borderColor = UIColor.lightGray.cgColor
        progress.layer.borderWidth = 1
        progress.clipsToBounds = true
        return progress
    }()
    
    let progressLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .red
        lb.font = Fonts.by(name: .medium, size: 16)
        lb.text = "0 %"
        return lb
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
        
        self.animateCheckFace()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultFaceButton.layer.cornerRadius = resultFaceButton.bounds.size.width / 2
        avatarMaidImage.layer.cornerRadius = 60
        avatarPhotoImage.layer.cornerRadius = 60
        
        print("viewDidLayoutSubviews")
    }
    
    override func setupView() {
        self.view.addSubview(avatarMaidImage)
        self.view.addSubview(avatarPhotoImage)
        self.view.addSubview(resultFaceButton)
        self.view.addSubview(progressBar)
        self.view.addSubview(progressLabel)
        

        avatarMaidImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        avatarMaidImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarMaidImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        avatarMaidImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        avatarPhotoImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        avatarPhotoImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarPhotoImage.topAnchor.constraint(equalTo: avatarMaidImage.topAnchor, constant: 0).isActive = true
        avatarPhotoImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: progressBar)
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120).isActive = true
        
        progressLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor, constant: 0).isActive = true
        progressLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20).isActive = true
        
        resultFaceButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resultFaceButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        resultFaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultFaceButton.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    func animateCheckFace() {
        //let transform = CGAffineTransform.identity.translatedBy(x: 110, y: 1)
        //let transformB = CGAffineTransform.identity.translatedBy(x: -100, y: 1)
        let transform = CATransform3DMakeTranslation(100, 1 , 0);
        let transformB = CATransform3DMakeTranslation(-115, 1, 0)
        let scale = CATransform3DMakeScale(1, 1, 1);
        
        timer = Timer.scheduledTimer(timeInterval: 15.0 / Double(value), target: self, selector: #selector(update), userInfo: nil, repeats: true)
        Sound.play(file: "facesuccess", fileExtension: "mp3", numberOfLoops: 0)
        UIView.animate(withDuration: 15.0, animations: {
            //self.avatarMaidImage.layer.setAffineTransform(transform)
            //self.avatarPhotoImage.layer.setAffineTransform(transformB)
            self.avatarMaidImage.layer.transform = CATransform3DConcat(transform, scale)
            self.avatarPhotoImage.layer.transform = CATransform3DConcat(transformB, scale)
        },completion: { (success: Bool) in
            if self.value < 50 {
                Sound.play(file: "icorrect", fileExtension: "mp3", numberOfLoops: 0)
            } else{
                Sound.stop(file: "facesuccess", fileExtension: "mp3")
            }
            self.resultFaceButton.isHidden = false
        })
    }
    
    func update() {
        progressBar.linearLoadingWith(progress: CGFloat(progressValue))
        progressValue += 1
        if progressValue == value {
            timer?.invalidate()
        }
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
    func handleSuccess(_ btnFace: CustomFaceButton) {
        //btnFace.type = .failure
        for vc in (self.navigationController?.viewControllers ?? []) {
            guard vc is TaskManagementVC else { continue }
            delegate?.checkInMaid!()
            self.navigationController?.popToViewController(vc, animated: true)
            return
        }
        print("Handle Button Success")
    }
    
    func handleFailure(_ btnFace: CustomFaceButton) {
        //btnFace.type = .success
        self.navigationController?.popViewController(animated: true)
        print("Handle Button Failure")
    }
}
