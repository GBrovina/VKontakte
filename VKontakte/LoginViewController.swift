//
//  ViewController.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 01.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    private var handle:AuthStateDidChangeListenerHandle!

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginText: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var goButton: UIButton!
    
    @IBAction func goButton(_ sender: Any) {
        let indicator = CustomIndicator()
            view.addSubview(indicator)
            indicator.frame = CGRect(x: 130, y: 480, width: 30, height: 30)
            indicator.startAnimations()
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        guard let email = loginText.text, let password = passwordText.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) {(result,error) in
            print (result?.user.uid)
           Database.database().reference(withPath: "user").updateChildValues(["\(String(describing: result?.user.uid))":email])
            if result?.user != nil {
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
        }
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        alert.addTextField { loginText in
                loginText.placeholder = "Enter your email"
        }
        alert.addTextField { passwordText in
                passwordText.isSecureTextEntry = true
                passwordText.placeholder = "Enter your password"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                
                    guard let loginText = alert.textFields?[0],
                        let passwordText = alert.textFields?[1],
                        let password = passwordText.text,
                        let email = loginText.text else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                    if let error = error {
                        self?.showLoginError()
                    } else {
                        Auth.auth().signIn(withEmail: email, password: password){(result,error) in
                            Database.database().reference(withPath: "user").updateChildValues(["\(String(describing: result?.user.uid))":email])}
                    }
                }
            }
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }


   
    //    override func shouldPerformSegue (withIdentifier identifier: String, sender:Any?)->Bool{
    
        
//        let checkResult = checkUserData()
//        if !checkResult{
//            showLoginError()
//              }
//
//        return checkResult
//          }
    
    
//    func checkUserData()->Bool{
//         guard let login=loginText.text,
//         let password = passwordText.text else {return false}
//             if login == "admin" && password == "admin"{
//                return true
//                }else{
//                return false
//                }
//          }
        
    func showLoginError(){
          let alter=UIAlertController(title: "Error", message: "Неверный логин или пароль", preferredStyle: .alert)
          let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
              alter.addAction(action)
              present(alter,animated: true,completion: nil)
          }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print (#function)
         
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
//        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                self.performSegue(withIdentifier: "logIn", sender: nil)
//                self.passwordText.text = nil
//                self.loginText.text = nil
//            }
//        }

         
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @objc func keyboardWasShown (notification:Notification) {
           let info = notification.userInfo! as NSDictionary
           let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
           let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
           self.scrollView?.contentInset=contentInsets
           scrollView?.scrollIndicatorInsets=contentInsets
       }
       
       @objc func keyboardWillBeHidden(notification:Notification) {
           let contentInsets = UIEdgeInsets.zero
           scrollView?.contentInset = contentInsets
       }

}

