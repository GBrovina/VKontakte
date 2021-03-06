//
//  Services.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 15.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService{
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    let myQueue = DispatchQueue(label: "My")
   
//  MARK: -List of Friends
    func listOfFriends(){
        let apiKey = Session.instance.token
        let path = "/method/friends.get"
        let dataB:DataBase = .init()
            
        let parameters:Parameters = [
            "order":apiKey,
            "fields":"nickname, photo_200_orig",
            "extended": 1,
            "access_token":apiKey,
            "v":5.103
        ]
    
        let url = baseUrl+path
        
        myQueue.async {
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            self.myQueue.async{
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let friend = json["response"]["items"].arrayValue.map {Friends($0)}
                    
    //                DispatchQueue.main.async {
                    dataB.saveFriends(friends: friend)
                   print(dataB.friends())
    //                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            }
    }
}
}
//    MARK: - List of Group
     func listOfGroup(){
        let apiKey = Session.instance.token
        let path = "/method/groups.get"
        let dataB:DataBase = .init()
        
        let parameters:Parameters = [
            "order":apiKey,
            "extended":1,
            "access_token":apiKey,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
            myQueue.async {
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                self.myQueue.async{
                switch response.result {
                        case .success(let value):
                        let json = JSON(value)
                        let group = json["response"]["items"].arrayValue.map {MyGroup($0)}
                            
//                            DispatchQueue.main.async {
                        dataB.saveGroups(groups: group)
//                            }
                        
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                }
        }
    }
    }
//    MARK: - List of News
    func listOfNews(startFrom: String, completion: @escaping (String)-> Void) {
        let apiKey = Session.instance.token
        let path = "/method/newsfeed.get"
        let dataB:DataBase = .init()
        
        let parameters:Parameters = [
                  "access_token":apiKey,
                  "startFrom": startFrom,
                  "extended":1,
                  "filters": "post",
                  "v":5.103
              ]
        
        let url = baseUrl+path
                    
        myQueue.async {
        
                    AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                        self.myQueue.async{
                        switch response.result {
                                case .success(let value):
                                    let json = JSON(value)
                                    let news = json["response"]["items"].arrayValue.map {News($0)}
                                    let nextFrom = json["response"]["next_from"].stringValue
                                    
                                    
                                    dataB.saveNews(news: news)
                
                                    completion(nextFrom)
                            
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                        }
            }
    }
    }
//    MARK: - photo of Person
    func photoOfPerson(_ userId:Int){
        let apiKey = Session.instance.token
        let path = "/method/photos.getAll"
        let dataB:DataBase = .init()
        
        let parameters:Parameters = [
            "access_token":apiKey,
            "owner_id" : userId,
            "extended": 1,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
           myQueue.async {
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
//            print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let photo = json["response"]["items"].arrayValue.map {PhotoService($0)}
                    
//                    DispatchQueue.main.async {
                    dataB.savePhoto(photo: photo)
//                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    }
    
//    MARK: - Reqest for Operations
    
    func reqestForOperation() -> DataRequest{
        let apiKey = Session.instance.token
            let path = "/method/friends.get"
                
            let parameters:Parameters = [
                "order":apiKey,
                "fields":"nickname, photo_200_orig",
                "extended": 1,
                "access_token":apiKey,
                "v":5.103
            ]
        
            let url = baseUrl+path
            return AF.request(url, method: .get, parameters: parameters)
    }
}


