//
//  Group.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//class MyGroup {
//
//
//    var groupName:String
//    var imageGroup:UIImage
//
//    init(groupName:String,imageGroup:UIImage) {
//        self.groupName = groupName
//        self.imageGroup = imageGroup
//    }
//}

class MyGroup{
    var groupName:String
    var imageGroup:String

    init(_ json:JSON) {
        self.groupName = json["name"].stringValue

        self.imageGroup = json["photo_50"].stringValue

    }


}
