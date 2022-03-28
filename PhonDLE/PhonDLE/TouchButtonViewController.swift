//
//  TouchButtonViewController.swift
//  PhonDLE
//
//  Created by Jin younkyum on 2022/03/28.
//

import UIKit

class TouchButtonViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var fakeButton: UIButton!
    
    @IBOutlet weak var realButton: UIButton!
    
    // MARK: - Actions

    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fakeButton.setTitle("BOO", for: .highlighted)
        
    }
    
    
}
