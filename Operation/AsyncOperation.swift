//
//  AsyncOperation.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 26.04.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import Foundation

class AsyncOperation:Operation {
    
    public enum State: String {
            case ready, executing, finished
            
            fileprivate var keyPath: String {
                return "is" + rawValue.capitalized
            }
        }
        
        public var state = State.ready {
            willSet {
                willChangeValue(forKey: newValue.keyPath)
                willChangeValue(forKey: state.keyPath)
            }
            didSet {
                didChangeValue(forKey: oldValue.keyPath)
                didChangeValue(forKey: state.keyPath)
            }
        }
    
    override var  isAsynchronous: Bool{
        return true
    }
    
    override var isReady: Bool{
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool{
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled{
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
   
    }


