//
//  NameSettingViewController.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class NameSettingViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Name"
        // Do any additional setup after loading the view.
    }
    @IBAction func textChanged(_ sender: Any) {
        self.confirmButton.isEnabled = true
    }
    
    @IBAction func confirmPushed(_ sender: Any) {
        getUserIsReal(user: self.inputField.text!)
    }
    
    func getUserIsReal(user: String) {
        let booksUrlStr = "https://api.github.com/users/\(user)/events"
        
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error { // 에러가 발생함
                 self.showErrorAlert(with: error.localizedDescription)
                 print("error1")
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse else {
                 self.showErrorAlert(with: "Invalid Response") // response가 없음
                 return
             }
             
             guard (200...299).contains(httpResponse.statusCode) else {
                 self.showErrorAlert(with: "\(httpResponse.statusCode)") // status code 값 비교
                 return
             }
             
             guard let data = data else { // 데이터 동기화 안될경우 오류 발생
                 fatalError("Invalid Data")
             }
             DispatchQueue.main.async {
                 UserDefaults.standard.set(self.inputField.text!, forKey: userNameKey)
                 self.presentingViewController?.dismiss(animated: true)
             }
             
         }
         task.resume()
        
        
        
    }
    
}
