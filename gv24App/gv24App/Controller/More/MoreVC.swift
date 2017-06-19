//
//  MoreVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit


class MoreVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SwitchCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMore.register(MoreItemCell.self, forCellWithReuseIdentifier: itemCellId)
        collectionMore.register(MoreUserCell.self, forCellWithReuseIdentifier: userCellId)
        collectionMore.register(MoreSocialCell.self, forCellWithReuseIdentifier: socialCellId)
        collectionMore.register(SwitchCell.self, forCellWithReuseIdentifier: switchCellId)
        collectionMore.register(BaseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
    }
    
    let userCellId = "userCellId"
    let itemCellId = "itemCellId"
    let socialCellId = "socialCellId"
    let switchCellId = "switchCellId"
    let headerId = "headerId"
    lazy var collectionMore : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
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
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
                cell.text = "GeneralStatistic"
                return cell
            }
            
        case 1:
            
            switch indexPath.item
            {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: switchCellId, for: indexPath) as! SwitchCell
                cell.delegate = self
                cell.text = "Announcement"
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
                cell.text = "Language"
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
                return cell
            }
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
            switch indexPath.item
            {
            case 0:
                cell.text = "AboutUs"
            case 1:
                cell.text = "TermsOfUse"
            case 2:
                cell.text = "Contact"
            default: break
                
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: socialCellId, for: indexPath) as! MoreSocialCell
            switch indexPath.item
            {
            case 0:
                cell.text = "Chia sẻ ứng dụng GV24"
                cell.icon = .androidShareAlt
            case 1:
                cell.text = "FollowUsOnFacebook"
                cell.icon = .socialFacebook
            default: break
                
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
            cell.text = "Logout"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! MoreItemCell
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
            UserHelpers.logOut()
            self.dismiss(animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func handleSection0(item : Int){
        if item == 0 {
            self.push(viewController: ProfileVC())
        }else{
            self.push(viewController: GeneralStatisticVC())
        }
    }
    func handleSection1(item : Int){
        if item == 0 {
            
        }else{
            self.push(viewController: LanguageVC())
        }
    }
    func handleSection2(item : Int){
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
        
    }
    func notification(isOn: Bool) {
        print(isOn)
    }
    
    override func localized() {
        super.localized()
        self.collectionMore.reloadData()
        title = LanguageManager.shared.localized(string: "More")
    }
}
