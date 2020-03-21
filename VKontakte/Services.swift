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

class VKService{
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
   
    
    func listOfFriends(completion: @escaping (Swift.Result<[Friends],Error>) -> Void){
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
        
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            print(response.value)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let friend = json["response"]["items"].arrayValue.map {Friends($0)}
                print(friend.count)
                completion(.success(friend))
            case .failure(let error):
                print(error.localizedDescription)
            }
    }
}
     func listOfGroup(completion: @escaping (Swift.Result<[MyGroup],Error>) -> Void){
        let apiKey = Session.instance.token
        let path = "/method/groups.get"
        
        let parameters:Parameters = [
            "order":apiKey,
            "extended":1,
            "access_token":apiKey,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
            
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value)
                switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            let group = json["response"]["items"].arrayValue.map {MyGroup($0)}
                            print(group.count)
                            completion(.success(group))
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
        }
    }
    func photoOfPerson(_ userId:Int,completion: @escaping (Swift.Result<[PhotoService],Error>) -> Void ){
        let apiKey = Session.instance.token
        let path = "/method/photos.getAll"
    
        
        let parameters:Parameters = [
            "access_token":apiKey,
            "owner_id" : userId,
            "extended": 1,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
            
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let photo = json["response"]["items"].arrayValue.map {PhotoService($0)}
                    print(photo.count)
                    completion(.success(photo))
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
