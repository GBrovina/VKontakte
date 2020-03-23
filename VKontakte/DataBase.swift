//
//  DataBase.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 23.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class DataBase {
    
    func saveGroups ( groups:[MyGroup] ) {
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print (error)
        }
    }
    
    func groups() -> [MyGroup] {
            do{
                let realm = try Realm()
                let objects = realm.objects(MyGroup.self)
                return Array(objects)
            }
            catch {
                return []
            }
        }
    
    
    func saveFriends ( friends:[Friends] ) {
           do{
               let realm = try Realm()
               realm.beginWrite()
               realm.add(friends)
               try realm.commitWrite()
           } catch {
               print (error)
           }
       }
       
       func friends() -> [Friends] {
               do{
                   let realm = try Realm()
                   let objects = realm.objects(Friends.self)
                   return Array(objects)
               }
               catch {
                   return []
               }
           }
    
    func savePhoto ( photo:[PhotoService] ) {
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photo)
            try realm.commitWrite()
        } catch {
            print (error)
        }
    }
    
    func photo() -> [PhotoService] {
            do{
                let realm = try Realm()
                let objects = realm.objects(PhotoService.self)
                return Array(objects)
            }
            catch {
                return []
            }
        }
}

