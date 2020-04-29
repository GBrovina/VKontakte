//
//  ParseData.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 27.04.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ParseData:Operation{
    
    var friends:[Friends]=[]
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else {return}
        let json = try! JSON(data: data)
        let outputfriends:[Friends] = json["response"]["items"].arrayValue.map {Friends($0)}
        friends = outputfriends
        
    }
    
}
