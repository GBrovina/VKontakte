//
//  Services.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 15.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import Alamofire

class VKService{
    
    let baseUrl = "https://api.vk.com"
//    let apiKey = Session.instance.token
   
    
    func listOfFriends(){
    let apiKey = Session.instance.token
    let path = "/method/friends.get"
    
    let parameters:Parameters = [
        "order":apiKey,
        "fields":"first_name",
        "access_token":apiKey,
        "v":5.103
    ]
    
        let url = baseUrl+path
        
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
        print(repsonse.value)
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
