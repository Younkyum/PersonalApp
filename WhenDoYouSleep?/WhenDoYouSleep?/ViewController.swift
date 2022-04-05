//
//  ViewController.swift
//  WhenDoYouSleep?
//
//  Created by Jin younkyum on 2022/04/05.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Times
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var oneHourHalf: UILabel!
    @IBOutlet weak var threeHours: UILabel!
    @IBOutlet weak var forHourHalf: UILabel!
    @IBOutlet weak var sixHours: UILabel!
    @IBOutlet weak var sevenHourHalf: UILabel!
    
    // MARK: - Set Time
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var setSixHours: UILabel!
    @IBOutlet weak var setSevenHours: UILabel!
    
    // MARK: - Properties
    var timer: Timer!
    var nextTimer: Timer!
        
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(getNowTime),
                                     userInfo: nil,
                                     repeats: true)
        nextTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(timeSet), userInfo: nil, repeats: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let datePickerView = sender.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "a hh:mm"
        
        setSixHours.text = formatter.string(from: Date(timeInterval: -21600, since: datePickerView))
        setSevenHours.text = formatter.string(from: Date(timeInterval: -27000, since: datePickerView))
    }
    
    
    
    

    // MARK: - Methods
    @objc private func getNowTime(){
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        
        self.currentTime.text = dateFormatter.string(from: now)
    }
    
    @objc private func timeSet() {
        let ct = DateFormatter()
        ct.dateFormat = "a hh:mm"
        
        oneHourHalf.text = ct.string(from: Date(timeIntervalSinceNow: 5400))
        threeHours.text = ct.string(from: Date(timeIntervalSinceNow: 10800))
        forHourHalf.text = ct.string(from: Date(timeIntervalSinceNow: 16200))
        sixHours.text = ct.string(from: Date(timeIntervalSinceNow: 21600))
        sevenHourHalf.text = ct.string(from: Date(timeIntervalSinceNow: 27000))
    }
    
    private func changeImage() {
        
    }
}

