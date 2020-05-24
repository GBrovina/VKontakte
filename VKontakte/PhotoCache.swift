//
//  PhotoService.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 13.05.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import UIKit
import Alamofire

private protocol Reload {
    func reloadData( indexPath:IndexPath)
}

class PhotoCache {
    
    
    
    private var cacheLifeTime:TimeInterval = 60*5
    private var images = [String:UIImage]()
    private static let namePath:String = {
        
        let namePath = "image"
        
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return namePath}
        let url = cacheDirectory.appendingPathComponent(namePath, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path){
            try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return namePath
    }()
//    MARK: - get File Path
    func getFilePath( url:String) -> String? {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        let hashe = url.split(separator: "/").last ?? "default"
        return cacheDirectory.appendingPathComponent(PhotoCache.namePath+"/"+hashe, isDirectory: true).path

    }

//    MARK: - save Image To Cache
    func saveImageToCache( url:String, image:UIImage) {
       guard let fileName = getFilePath(url: url),
        let data = image.pngData() else {return}
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    

//    MARK: - read Image From Cache
    func readImageFromCache(url:String) -> UIImage?{
        guard let filePath = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath:filePath),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else {return nil}
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: filePath) else { return nil }

        
        images[url] = image
        
        return image
    }
    
    

//    MARK: - Load Image
    let cacheQueue = DispatchQueue(label: "cache")
    let myqueue = VKService().myQueue
    
    func loadImage (for indexPath:IndexPath, at url:String){
        AF.request(url).responseData(queue: myqueue){ [weak self] response in
            guard let data = response.data,
            let image = UIImage (data: data) else {return}
            
            self?.images[url] = image
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadData(indexPath: indexPath)
            }
            
        }
    }
//    MARK: - method photo
    func photo(indexPath: IndexPath,at url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = readImageFromCache(url: url) {
            image = photo
        } else {
            loadImage(for: indexPath, at: url)
        }
        return image
    }
    
    private let container:Reload
    
    init(table:UITableView) {
        container = Table(table: table)
    }
    init(collection:UICollectionView) {
        container = Collection(collection: collection)
        
    }
    
}


//    MARK: - extention class
extension PhotoCache {
    
    class Table:Reload {
        func reloadData(indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let table:UITableView
        init(table:UITableView) {
            self.table = table
        }
        
    }
    
    class Collection:Reload {
           func reloadData(indexPath: IndexPath) {
              collection.reloadItems(at: [indexPath])
           }
           
           let collection:UICollectionView
           init(collection:UICollectionView) {
               self.collection = collection
           }
           
       }
}


