//
//  LanguageVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class LanguageVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "Language")
        tableViewLanguage.register(UITableViewCell.self, forCellReuseIdentifier: languageCellId)
        // Do any additional setup after loading the view.
    }
    let languageCellId = "languageCellId"
    lazy var tableViewLanguage : UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        // MARK: - TEAM LEAD: remove all separated lines
        tb.tableFooterView = UIView()
        return tb
    }()
    
    override func setupView() {
        view.addSubview(tableViewLanguage)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: tableViewLanguage)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: tableViewLanguage)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageManager.shared.listLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: languageCellId, for: indexPath)
        cell.textLabel?.font = Fonts.by(name: .regular, size: 15)
        cell.textLabel?.text = LanguageManager.shared.listLanguage[indexPath.row].language
        if indexPath.row == LanguageManager.shared.current{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = LanguageManager.shared.listLanguage[indexPath.row]
        LanguageManager.shared.setCurrent(language: language)
        LanguageManager.shared.current = indexPath.row
        goBack()
    }
}
