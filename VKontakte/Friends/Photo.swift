//
//  Photo.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhotoService {
    var userId:Int
    var userPhoto:String
    
    init(_ json:JSON) {
        self.userId = json["id"].intValue
        self.userPhoto = json["sizes"][3]["url"].stringValue
    }
}
