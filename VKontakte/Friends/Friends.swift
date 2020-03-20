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

//class Friends{
//    var userName:String
//    var avatar:UIImage
//    var photos:[UIImage]
//
//
//
//    init(userName:String,avatar:UIImage,photos:[UIImage]) {
//        self.userName = userName
//        self.avatar  = avatar
//        self.photos = photos
//    }
//
//
//}
class Friends{
    var userName:String
    var avatar:String
//    var photos:[UIImage]



    init(_ json:JSON) {
        self.userName = json["first_name"].stringValue
        
        self.avatar = json["photo_200_orig"].stringValue
        
    }


}

