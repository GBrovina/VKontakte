//
//  Promise.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 03.05.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

class PromiseService{
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    
    public func forecastGroup(on queue:DispatchQueue = .init(label: "My"))->Promise<[MyGroup]>{
     
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
                    
        let promise = Promise<[MyGroup]> {resolver in
            AF.request(url, method: .get, parameters: parameters).responseJSON
                { response in
                  switch response.result {
                                case .success(let value):
                                let json = JSON(value)
                                let group = json["response"]["items"].arrayValue.map {MyGroup($0)}
        
                                dataB.saveGroups(groups: group)
                                resolver.fulfill(group)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    resolver.reject(error)
                        }
                }
        }
        return promise
    }
}
