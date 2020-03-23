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
import RealmSwift

class PhotoService: Object{
    @objc dynamic var userId:Int = 0
    @objc dynamic var userPhoto:String = ""
    
   convenience init(_ json:JSON) {
        self.init()
        self.userId = json["id"].intValue
        self.userPhoto = json["sizes"][3]["url"].stringValue
    }
}
