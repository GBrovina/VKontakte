//
//  Friends.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 08.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit

class Friends{
    var userName:String
    var avatar:UIImage
    var photos:[UIImage]
    
    init(userName:String,avatar:UIImage,photos:[UIImage]) {
        self.userName = userName
        self.avatar  = avatar
        self.photos = photos
    }
}

