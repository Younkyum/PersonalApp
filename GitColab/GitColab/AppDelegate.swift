//
//  AppDelegate.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

let initialKey = "initialKey"
let userNameKey = "userNameKey"
let followerKey = "followerKey"
var eventLists = [[Event]()]
var userCommitCount = 0


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if !UserDefaults.standard.bool(forKey: initialKey) {
            UserDefaults.standard.set("github", forKey: userNameKey)
            let list = ["github"]
            UserDefaults.standard.set(list, forKey: followerKey)
            UserDefaults.standard.set(true, forKey: initialKey)
        }
        
    
        getMemberAPI(user: "Younkyum")
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func getMemberAPI(user: String) {
        let follower = user
        let booksUrlStr = "https://api.github.com/users/\(follower)/events"
        
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error { // 에러가 발생함
                 print(error)
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse else {
                 return
             }
             
             guard (200...299).contains(httpResponse.statusCode) else {
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
                 print(eventlist[0])

             } catch {
                 print(error)
             }
         }
         task.resume()
        
    }
}

