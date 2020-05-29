//
//  ReloadData.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 24.05.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import RealmSwift

class ReloadTable:Operation{
    
    
    override func main(){
        let base = DataBase()
        guard let parseData = dependencies.first as? ParseData else {return}
        try! base.saveFriends(friends: parseData.friends)
    }
    
}
