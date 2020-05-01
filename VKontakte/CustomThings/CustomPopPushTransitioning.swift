//
//  CustomPopPushTransitioning.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 02.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class CustomPushAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view)
        
        
        destination.view.frame = source.view.frame
        destination.view.transform = .init(rotationAngle: -.pi/2)
        destination.view.frame.origin.x += destination.view.frame.width
        
        
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.8,
                                                       animations: {
                                                        destination.view.transform = destination.view.transform.rotated(by: .pi/2)
                                                        destination.view.frame.origin.x = 0
                                    })

                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        destination.view.transform = .identity
                                    })
                                    
                                    
        }){ finished in
            if finished && !transitionContext.transitionWasCancelled{
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}



class CustomPopAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view)
       
        
        destination.view.frame = source.view.frame
        destination.view.transform = .init(rotationAngle: -.pi/2 )
        destination.view.frame.origin.x += destination.view.frame.width

    
    
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.8,
                                                       animations: {
                                                        destination.view.transform = destination.view.transform.rotated(by: -.pi*3/2)
                                                        destination.view.frame.origin.x = 0
                                                        destination.view.frame.origin.y = 0
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        destination.view.transform = .identity
                                    })
                                    
                                    
        }){ finished in
            if finished && !transitionContext.transitionWasCancelled{
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
