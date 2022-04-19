//
//  CaesarViewController.swift
//  Cripto Collection
//
//  Created by Jin younkyum on 2022/04/19.
//

import UIKit

class CaesarViewController: UIViewController {
    var keyList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    
    
    @IBOutlet weak var encryptedText: UILabel!
    @IBOutlet weak var originalTextField: UITextField!
    @IBOutlet weak var keyPickerView: UIPickerView!
    @IBOutlet weak var encryptionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 231/255, green: 209/255, blue: 146/255, alpha: 1)
    }

    @IBAction func encryptionButtonPushed(_ sender: Any) {
        if self.originalTextField.text?.count != 0 {
            encryptedText.text = solution(self.originalTextField.text ?? "HELLO",
                                          keyList[Int(keyPickerView.selectedRow(inComponent: 0).description)!])
        }
    }
    
    
    func solution(_ s:String, _ n:Int) -> String {
        let upperString = Array("abcdefghijklmnopqrstuvwxyz".uppercased())
        let lowerString = Array("abcdefghijklmnopqrstuvwxyz")
        let inputString = Array(s)
        var result = ""
       
        for i in inputString {
            // 주어진 문자열의 i번째 문자가 대문자 배열에 포함되었을 경우
            if upperString.contains(i) {
                // 대문자 배열에서 해당 문자의 위치를 찾고, 그 위치에 n을 더한 값을 저장
                var indexNum = upperString.firstIndex(of: i)! + n
                
                // 저장된 위치가 25보다 클 경우, 26을 빼줌으로써 다시 처음부터 위치를 찾을 수 있도록
                if indexNum > 25 {
                    indexNum = indexNum - 26
                }

                // 대문자 배열에서 찾은 위치의 문자를 result 배열에 추가
                result.append(upperString[indexNum])
            }
            
            // 주어진 문자열의 i번째 문자가 소문자 배열에 포함되었을 경우
            else if lowerString.contains(i) {
                var indexNum = lowerString.firstIndex(of: i)! + n
                
                if indexNum > 25 {
                    indexNum = indexNum - 26
                }
                
                result.append(lowerString[indexNum])
            }
            
            // 주어진 문자열의 i번째 문자가 공백일 경우
            else {
                result.append(i)
            }
        }
        return result
    }
}


extension CaesarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(keyList[row])
    }
    
}
