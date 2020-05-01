//
//  Friends.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class Friends: Object{
    @objc dynamic var userName:String = ""
    @objc dynamic var avatar:String = ""
    @objc dynamic var userId:Int = 0



    convenience init(_ json:JSON) {
    self.init()
        self.userName = json["first_name"].stringValue+" "+json["last_name"].stringValue
        
        self.avatar = json["photo_200_orig"].stringValue
        
        self.userId = json["id"].intValue
    }

    override static func primaryKey() -> String? {
        return "userId"
    }
}

