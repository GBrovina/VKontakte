//
//  CustomNavigationBar.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 02.03.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

class CustomNavigationController:UINavigationController, UINavigationControllerDelegate {
    
    private let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition:nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push{
            interactiveTransition.viewController = toVC
          return CustomPushAnimation()
        } else if operation == .pop{
            if navigationController.viewControllers.first != toVC{
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimation()
        }
        return nil
    }
}
