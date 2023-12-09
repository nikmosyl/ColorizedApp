//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by nikita on 09.12.23.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as? SettingViewController
        settingVC?.delegate = self
        settingVC?.color = self.view.backgroundColor
    }
}

// MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    func setColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
}
