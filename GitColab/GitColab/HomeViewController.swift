//
//  HomeViewController.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userList = ["Younkyum"]
    var eventLists = [[Event]()]
    var fCommits = [Int]()

    @IBOutlet weak var todayCommitCount: UILabel!
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        base()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func base() {
        let user = whoIsUser()
        mainNameLabel.text = user
        
        self.userCollectionView.register(UINib(nibName:"MemberCollectionViewCell" , bundle: .main), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        userList = getFollowers()
        print(userList)
        fCommits = getTodayCommits(lists: eventLists)
        print(fCommits)
        userCollectionView.reloadData()
        followerLabel.text = "Follower " + String(userList.count)
        setupFlowLayout()
        getUserAPI(user: user)
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 1.83, height: halfWidth * 0.45)
        self.userCollectionView.collectionViewLayout = flowLayout
    }
    
    // USER 리턴 (Default: Younkyum)
    func whoIsUser() -> String {
        return UserDefaults.standard.string(forKey: userNameKey)!
    }
    
    func getFollowers() -> Array<String> {
        let list = UserDefaults.standard.array(forKey: followerKey) as? [String] ?? [String]()
        return list
    }
    
    // API를 받아서 list로 만듬
    func getUserAPI(user: String) {
        let booksUrlStr = "https://api.github.com/users/\(user)/events"
        
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error { // 에러가 발생함
                 self.showErrorAlert(with: error.localizedDescription)
                 print(error)
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
                 DispatchQueue.main.async { // Main에서 text 값 변경
                     self.todayCommitCount.text = String(self.countTodayCommits(list: eventlist))
                 }
                 

             } catch {
                 print(error)
                 self.showErrorAlert(with: error.localizedDescription)
             }
         }
         task.resume()
    }
    
    // Int 형태로 오늘 커밋 개수 출력
    func countTodayCommits(list:[Event]) -> Int {
        var totalCount = 0
        let today = self.today()
        
        print("its me")
        print(list)
        
        for i in list {
            if i.created_at.contains(today) && i.type == "PushEvent" {
                totalCount += 1
            }
        }
        print(totalCount)
        return totalCount
    }
    
    // String 형태로 오늘 날짜 출력
    func today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = formatter.string(from: Date())
        return now
    }
    
    func getMemberAPI(user: String) {
        let booksUrlStr = "https://api.github.com/users/\(user)/events"
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
        let task = session.dataTask(with: url) { [self] (data, response, error) in
             if let error = error { // 에러가 발생함
                 self.showErrorAlert(with: error.localizedDescription)
                 print(error)
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
            print("hello1")
             
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
                 self.eventLists.append(eventlist)
                 print("hello2")
                 
                 
             } catch {
                 print(error)
                 self.showErrorAlert(with: error.localizedDescription)
             }
         }
        task.resume()
    }
    
    func getTodayCommits(lists:[[Event]]) -> [Int] {
        var countList = [Int]()
        for i in userList{
            getMemberAPI(user: i)
            print(eventLists)
        }
        for i in lists {
            let a = countTodayCommits(list: i)
            countList.append(a)
            print(a)
        }
        return countList
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        
        cell.nameLabel.text = userList[indexPath.row]
        let counts = fCommits[indexPath.row]
        cell.commitLabel.text = String(counts)
        
        return cell
    }
    
}
