//
//  HomeViewController.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userList = ["User1", "User2", "User3", "User4", "User5"]
    let user = "Younkyum"

    @IBOutlet weak var todayCommitCount: UILabel!
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userCollectionView.register(UINib(nibName:"MemberCollectionViewCell" , bundle: .main), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        setupFlowLayout()
        getUserAPI(user: user)
        // Do any additional setup after loading the view.
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 1.83, height: halfWidth * 0.45)
        self.userCollectionView.collectionViewLayout = flowLayout
    }
    
    func getUserAPI(user: String) {
        let booksUrlStr = "https://api.github.com/users/\(user)/events"
        
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 self.showErrorAlert(with: error.localizedDescription)
                 print(error)
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse else {
                 self.showErrorAlert(with: "Invalid Response")
                 return
             }
             
             guard (200...299).contains(httpResponse.statusCode) else {
                 self.showErrorAlert(with: "\(httpResponse.statusCode)")
                 return
             }
             
             guard let data = data else {
                 fatalError("Invalid Data")
             }
             
             do {
                 let decoder = JSONDecoder()
                 decoder.dateDecodingStrategy = .iso8601
                 
                 decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                     let container = try decoder.singleValueContainer()
                     let dateStr = try container.decode(String.self)
                     
                     let formatter = ISO8601DateFormatter()
                     formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
                     
                     return formatter.date(from: dateStr)!
                 })
                 
                 let eventlist = try decoder.decode([Event].self, from: data)
                 print(eventlist[0].type, eventlist[0].created_at, eventlist.count)
                 DispatchQueue.main.async {
                     self.todayCommitCount.text = String(self.countTodayCommits(list: eventlist))
                 }

             } catch {
                 print(error)
                 self.showErrorAlert(with: error.localizedDescription)
             }
         }
         task.resume()
    }
    
    func countTodayCommits(list:[Event]) -> Int {
        var totalCount = 0
        let today = self.today()
        
        for i in 0...(list.count - 1) {
            if list[i].created_at.contains(today) && list[i].type == "PushEvent" {
                totalCount += 1
            }
        }
        return totalCount
    }
    
    func today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = formatter.string(from: Date())
        return now
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == userList.count {
            cell.plusView.alpha = 1
            cell.todayCommitLabel.alpha = 0
            cell.commitLabel.alpha = 0
            cell.nameLabel.alpha = 0
        } else {
            cell.plusView.alpha = 0
            cell.nameLabel.text = userList[indexPath.row]
        }
        
        
        return cell
    }
    
    
}
