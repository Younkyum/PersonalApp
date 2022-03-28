//
//  TouchButtonViewController.swift
//  PhonDLE
//
//  Created by Jin younkyum on 2022/03/28.
//

import UIKit

class TouchButtonViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var fakebtnview: UIView!
    @IBOutlet weak var realbtnview: UIView!
    @IBOutlet weak var fakeButton: UIButton!
    
    @IBOutlet weak var realButton: UIButton!
    
    // MARK: - Actions
    @objc private func fakeButtonAction(_ sender: Any) {
        fakebtnview.alpha = 0
        realbtnview.alpha = 1
        
        realButton.isEnabled = true
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realButton.isEnabled = false
        realbtnview.alpha = 0
        fakeButton.isEnabled = true
        fakebtnview.alpha = 1
        
        let selector = #selector(fakeButtonAction(_:))
        fakeButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    
}
