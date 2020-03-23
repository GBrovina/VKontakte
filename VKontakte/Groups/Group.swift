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
import RealmSwift

class MyGroup: Object {
    @objc dynamic var groupName:String = ""
    @objc dynamic var imageGroup:String = ""

    convenience init(_ json:JSON) {
        self.init()
        self.groupName = json["name"].stringValue

        self.imageGroup = json["photo_50"].stringValue

    }
}
