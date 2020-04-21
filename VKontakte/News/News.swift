//
//  News.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.04.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class News: Object {
    @objc dynamic var sourceId:Int = 0
//    @objc dynamic var nameOfNews:String = ""
//    @objc dynamic var pictureOfNews:String = ""
    @objc dynamic var textNews:String = ""
    @objc dynamic var photoNews:String = ""
    @objc dynamic var likeCount:Int = 0
    @objc dynamic var repostCount:Int = 0
    @objc dynamic var messageCount:Int = 0

    convenience init(_ json:JSON) {
        self.init()
        self.sourceId = json["source_id"].intValue
        self.textNews = json["text"].stringValue
        self.photoNews = json["attachments"][0]["photo"]["sizes"][2]["url"].stringValue
        self.likeCount = json["likes"]["count"].intValue
        self.repostCount = json["reposts"]["count"].intValue
        self.messageCount = json["comments"]["count"].intValue
        

    }
}
