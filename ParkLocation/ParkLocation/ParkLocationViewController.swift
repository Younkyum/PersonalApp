//
//  ParkLocationViewController.swift
//  ParkLocation
//
//  Created by Jin younkyum on 2022/04/04.
//

import UIKit

class ParkLocationViewController: UIViewController {
    
    @IBOutlet weak var LocationPickerView: UIPickerView!
    
    let floorList = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "B1", "B2", "B3", "B4", "B5", "B6"]
    let alphabetList = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension ParkLocationViewController: UIPickerViewDelegate {
    
}

extension ParkLocationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return floorList.count
        case 1:
            return alphabetList.count
        case 2:
            return numberList.count
        default:
            return 0
        }
    }
    
    
}
