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
     func listOfGroup(){
        let apiKey = Session.instance.token
        let path = "/method/groups.get"
        
        let parameters:Parameters = [
            "order":apiKey,
            "extended":1,
            "access_token":apiKey,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
            
            AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
    }
    func photoOfPerson(){
        let apiKey = Session.instance.token
        let path = "/method/photos.get"
    
        
        let parameters:Parameters = [
            "album_id":"wall",
            "access_token":apiKey,
            "v":5.103
        ]
        
            let url = baseUrl+path
            
            
            AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
    }
}
