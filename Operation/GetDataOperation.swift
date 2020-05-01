//
//  GetDataOperation.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 26.04.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetDataOperation: AsyncOperation {
    
    var request:DataRequest
    var data:Data?
    
    init(request:DataRequest) {
        self.request = request
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()){ [weak self] responds in
            
            switch responds.result {
            case .success(let data):
            self?.data = responds.data
            case .failure(let error):
            print(error.localizedDescription)
            }
            self?.state = .finished
        }
    }
    
    override func cancel() {
        request.cancel()
        return cancel()
    }
    
}
