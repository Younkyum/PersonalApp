//
//  apiModule.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/06/01.
//

import UIKit

func getMemberAPI(user: String) -> Int {
    let follower = user
    let booksUrlStr = "https://api.github.com/users/\(follower)/events"
    var commitCount: Int
    
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
             print(eventlist[0].type)

         } catch {
             print(error)
         }
     }
     task.resume()
}

