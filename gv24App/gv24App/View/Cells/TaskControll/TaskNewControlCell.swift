//
//  TaskNewControllCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskNewControlCell: TaskControlCell {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath)
        return cell
    }
    let newCellId = "newCellId"
    override func setupView() {
        super.setupView()
    }

    override func register() {
        taskCollectionView.register(TaskNewCell.self, forCellWithReuseIdentifier: newCellId)
    }
}
