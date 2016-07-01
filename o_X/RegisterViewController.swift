//
//  RegisterViewController.swift
//  o_X
//
//  Created by avarn127 on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var suapahCoolEmailField: UITextField!
    @IBOutlet weak var supahCoolPasswordField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func supahCoolRegisterButton(sender: UIButton) {
        UserController.sharedInstance.register(email: suapahCoolEmailField.text!, password: supahCoolPasswordField.text!, onCompletion: {(user, string) in
            
            if user == nil {
                let alert = UIAlertController (title: "ERROR" , message: string , preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(alertAction1)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                
            }
        
        
        })
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