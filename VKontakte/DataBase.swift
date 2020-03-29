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
//   MARK: -Groups
    func saveGroups ( groups:[MyGroup] ) {
        do{
            let realm = try Realm()
            print (realm.configuration.fileURL)
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
    
 //   MARK: -Friends
    func saveFriends ( friends:[Friends] ) {
           do{
               let realm = try Realm()
               print (realm.configuration.fileURL)
               let oldList = realm.objects(Friends.self)
               realm.beginWrite()
               realm.delete(oldList)
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
   //   MARK: -Photo
    func savePhoto ( photo:[PhotoService] ) {
        do{
            let realm = try Realm()
            print (realm.configuration.fileURL)
            let oldListOfPhoto = realm.objects(PhotoService.self)
            realm.beginWrite()
            realm.delete(oldListOfPhoto)
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

