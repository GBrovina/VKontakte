//
//  Session.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 11.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class Session {
    static let instance = Session()
    
    private init(){}
    
    var token:String = .init()
    var userId:Int = .init()
}

