//
//  SettingsViewController.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settingOptions = ["User Name", "Themes", "Notifications"]

    @IBOutlet weak var settingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.register(UINib(nibName: "SettingTableViewCell", bundle: .main), forCellReuseIdentifier: "SettingTableViewCell")
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = settingOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NameSettingViewController") as? NameSettingViewController else {return}
            nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ThemeSettingViewController") as? ThemeSettingViewController else {return}
            nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationSettingViewController") as? NotificationSettingViewController else {return}
            nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
