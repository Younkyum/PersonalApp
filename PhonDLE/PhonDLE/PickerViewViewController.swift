//
//  PickerViewViewController.swift
//  PhonDLE
//
//  Created by Jin younkyum on 2022/03/28.
//

import UIKit

class PickerViewViewController: UIViewController {
    
    let makeAnger = [".", ".", ".", ".", ".", ",", ".", ".", ".", ".", ".", ".", ".", "."]
    let answer = 5
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var isItRightbtn: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func isItRight(_ sender: Any) {
        let firstIndex = picker.selectedRow(inComponent: 0)
        
        if firstIndex == answer {
            nextButton.isEnabled = true
            isItRightbtn.setTitle("Well Done", for: .normal)
            isItRightbtn.isEnabled = false
        } else {
            nextButton.isEnabled = false
            isItRightbtn.setTitle("Look Carefully", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false

    }
    

}

extension PickerViewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return makeAnger.count
    }
    
    
}

extension PickerViewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return makeAnger[row]
    }
}
