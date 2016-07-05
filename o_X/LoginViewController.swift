//
//  LoginViewController.swift
//  o_X
//
//  Created by avarn127 on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonPressed(sender: UIButton) {
        UserController.sharedInstance.login(email: loginEmailField.text!, password: loginPasswordField.text!, onCompletion: { user, error in
            if user == nil {
                let alert = UIAlertController (title: "UH OH" , message: error, preferredStyle: .Alert)
                let dismiss = UIAlertAction(title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(dismiss)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let  mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let viewController = mainStoryboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            }
        })
    
    }
}

    

    


