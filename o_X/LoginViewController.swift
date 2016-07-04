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
        UserController.sharedInstance.login(email email: loginEmailField.text, password: loginPasswordField.text, onCompletion: {(User?, String) in
            <#code#>
        }
    }
//    @IBAction func supahCoolRegisterButton(sender: UIButton) {
//        UserController.sharedInstance.register(email: suapahCoolEmailField.text!, password: supahCoolPasswordField.text!, onCompletion: {(user, string) in
//            
//            if user == nil {
//                let alert = UIAlertController (title: "ERROR" , message: string , preferredStyle:  UIAlertControllerStyle.Alert)
//                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
//                alert.addAction(alertAction1)
//                self.presentViewController(alert, animated: true, completion: nil)
//    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
