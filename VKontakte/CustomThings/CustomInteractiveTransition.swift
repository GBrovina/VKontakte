//
//  CustomInteractiveTransition.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 03.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class CustomInteractiveTransition:UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController? {
        didSet{
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    var hasStarted:Bool = false
    var shouldFinish:Bool = false
    
    @objc func handleScreenEdgeGesture (_ gesture:UIScreenEdgePanGestureRecognizer){
        switch gesture.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
            
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let relativeTransition = translation.x/(gesture.view?.bounds.width ?? 1)
            let progress = max(0, min(1,relativeTransition))
            shouldFinish = progress > 0.33
            update(percentComplete)
            
        case .ended:
            hasStarted = false
            if shouldFinish{
                finish()
            }
            else {
                cancel()
            }
            
        case .cancelled:
            hasStarted = false
            cancel()
            
        default:
            return
        }
    }
}
