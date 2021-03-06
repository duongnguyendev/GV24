//
//  MoreVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class MoreVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SwitchCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMore.register(MoreItemCell.self, forCellWithReuseIdentifier: itemCellId)
        collectionMore.register(MoreUserCell.self, forCellWithReuseIdentifier: userCellId)
        collectionMore.register(MoreSocialCell.self, forCellWithReuseIdentifier: socialCellId)
        collectionMore.register(SwitchCell.self, forCellWithReuseIdentifier: switchCellId)
        collectionMore.register(LogoutCell.self, forCellWithReuseIdentifier: logoutCellId)
        collectionMore.register(BaseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
        collectionMore.register(GeneralStatisticCell.self, forCellWithReuseIdentifier: statisticCellId)
    }
    
    let userCellId = "userCellId"
    let itemCellId = "itemCellId"
    let socialCellId = "socialCellId"
    let switchCellId = "switchCellId"
    let logoutCellId = "logoutCellId"
    let headerId = "headerId"
    let statisticCellId = "statisticCellId"
    lazy var collectionMore : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.white
        
        // MARK: - TEAM LEAD: collectionView needs to bounds for default
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.isDirectionalLockEnabled = false
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()


    override func setupView() {
        view.addSubview(collectionMore)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionMore)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: collectionMore)
    }
    
    //MARK: - Collection view delegate - datasourse
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 2
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellId, for: indexPath) as! MoreUserCell
                cell.iconImage.isHidden = true
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: statisticCellId, for: indexPath) as! GeneralStatisticCell
                cell.delegate = self
                return cell
            }
            
        case 1:
            
            switch indexPath.item
            {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: switchCellId, for: indexPath) as! SwitchCell
                cell.delegate = self
                cell.icon = .androidNotifications
                cell.text = "Notification"
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
                cell.text = "Language"
                cell.icon = .iosWorld
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
                cell.arrowRight.isHidden = true
                return cell
            }
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
            cell.arrowRight.isHidden = true
            switch indexPath.item
            {
            case 0:
                cell.text = "AboutUs"
                cell.icon = .iosPerson
                break
            case 1:
                cell.text = "TermsOfUse"
                cell.icon = .androidList
                break
            case 2:
                cell.text = "Contact"
                cell.icon = .iosEmail
                break
            default: break
                
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: socialCellId, for: indexPath) as! MoreSocialCell
            cell.arrowRight.isHidden = true
            //cell.iconImage.isHidden = true
            switch indexPath.item
            {
            case 0:
                cell.text = "ShareNGV247"
                cell.icon = .androidShareAlt
                break
            case 1:
                cell.text = "FollowUsOnFacebook"
                cell.icon = .androidPeople
                break
            default: break
                
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: logoutCellId, for: indexPath) as! LogoutCell
            cell.arrowRight.isHidden = true
            cell.iconImage.isHidden = true
            cell.titleLogout = "Logout"
            cell.delegate = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
            cell.arrowRight.isHidden = true
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 && indexPath.item == 0{
            return CGSize(width: view.frame.size.width, height: 70)
        }else{
            return CGSize(width: view.frame.size.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? BaseHeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            handleSection0(item: indexPath.item)
            break
        case 1:
            handleSection1(item: indexPath.item)
            break
        case 2:
            handleSection2(item: indexPath.item)
            break
        case 3:
            handleSection3(item: indexPath.item)
            break
        case 4:
            //logOut()
            break
        default:
            break
        }
    }
    
    func logOut() {
        let alert = UIAlertController(title: nil, message: LanguageManager.shared.localized(string: "AreYouSureYouWantToLogOut"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "Cancel"), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            UserHelpers.logOut()
            GIDSignIn.sharedInstance().signOut()
            if AccessToken.current != nil{
                let facebookLoginManager = LoginManager()
                facebookLoginManager.logOut()
            }
            UIView.transition(with: appDelegate!.window!!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                appDelegate?.window??.rootViewController = UINavigationController.init(rootViewController: SignInVC())
            }, completion: nil)
            //self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleSection0(item : Int) {
        if item == 0 {
            self.push(viewController: ProfileVC())
        }else{
            self.push(viewController: GeneralStatisticVC())
        }
    }
    func handleSection1(item : Int) {
        if item == 0 {
            
        }else{
            self.push(viewController: LanguageVC())
        }
    }
    func handleSection2(item : Int) {
        switch item {
        case 0:
            push(viewController: AboutUsVC())
            break
        case 1:
            push(viewController: TermsVC())
            break
        case 2:
            push(viewController: ContactVC())
            break
        default:
            break
        }
    }
    func handleSection3(item : Int){
        if item == 0{
            let text = LanguageManager.shared.localized(string: "ShareApp")
            
            // set up activity view controller
            let textToShare = [text as Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: [])
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)

        }else{
            let url = URL(string: "fb://profile/122998571630965")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }else{
                UIApplication.shared.openURL(URL(string: "https://www.facebook.com/Ng%C6%B0%E1%BB%9Di-Gi%C3%BAp-Vi%E1%BB%87c-247-122998571630965/")!)
            }
        }
    }
    func notification(isOn: Bool) {
        
        MoreService.shared.handleNotification(isOn: isOn) { (success) in
            if success{
                UserHelpers.turnNotificaitonOn(isOn)
            }else{
                
            }
        }
    }
    
    override func localized() {
        super.localized()
        self.collectionMore.reloadData()
        title = LanguageManager.shared.localized(string: "More")
    }
}

extension MoreVC: GeneralStatisticCellDelegate {
    func genaralStatic(cell: GeneralStatisticCell) {
       self.push(viewController: GeneralStatisticVC()) 
    }

}

extension MoreVC: LogoutCellDelegate {
    func logout(cell: LogoutCell) {
        logOut()
    }
}
