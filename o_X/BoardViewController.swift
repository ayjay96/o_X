//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    
    @IBOutlet weak var cancelGame: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var boardView: UIView!
    let myGameController = OXGameController.sharedInstance
    var networkMode: Bool = false
    
    override func viewDidLoad() {
        if networkMode == true{
            
        }
        else {
        newGameButton.hidden = true
        }
        super.viewDidLoad()
        print (OXGameController.sharedInstance.getCurrentGame().board)
        
        updateUI()
        
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        self.restartGame()
        newGameButton.hidden = true
        
    }
    
    func updateUI() {
        let board = OXGameController.sharedInstance.getCurrentGame().board
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(board[button.tag].rawValue, forState: .Normal)
            }
        }
        
        
    }

    
    @IBAction func cancelButtonPressed(sender: UIButton) {
    
            OXGameController.sharedInstance.cancelGame(OXGameController.sharedInstance.getCurrentGame().ID) { (error) in
            if error == nil{
                self.navigationController?.popViewControllerAnimated(true)
            }
            else
            {
                let alert = UIAlertController (title: "ERROR" , message: "Something went wrong (idk what though)", preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(alertAction1)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    @IBAction func logoutButtonPressed(sender: UIButton) {
        let storyboard = UIStoryboard (name: "Onboarding" , bundle: nil)
        
        let viewController = storyboard.instantiateInitialViewController()
        
        let application = UIApplication.sharedApplication()
        
        let window = application.keyWindow
        
        window?.rootViewController = viewController
        
    }
    
    @IBAction func refreshButtonPressed(sender: UIButton) {
        OXGameController.sharedInstance.viewGame(OXGameController.sharedInstance.getCurrentGame().ID) { (error) in
            if error == nil{
                self.updateUI()
                OXGame.whoseTurn(self: OXGame)
            }
            else {
                let alert = UIAlertController (title: "ERROR" , message: "Could not Resfresh Move", preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(alertAction1)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    // Create additional IBActions here.
    @IBAction func boardButtonPressed(sender: UIButton) {
        
        let cellType = myGameController.playMove(sender.tag)
        OXGameController.sharedInstance.playMove(OXGameController.sharedInstance.getCurrentGame().ID) { (move) in
            if move == nil{
                print("success")
            }
            else {
                let alert = UIAlertController (title: "ERROR" , message: "Invalid Move", preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(alertAction1)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        let gameState = myGameController.getCurrentGame().state()
        
        sender.setTitle(cellType.rawValue, forState: .Normal)
        sender.userInteractionEnabled = false
        
       
        if gameState == .Won {
            
            let alert = UIAlertController (title:"Game Over!" , message: "\(sender.currentTitle!) Won!" , preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                self.newGameButton.hidden = false
            })
            alert.addAction(dismiss)
            self.presentViewController(alert, animated: true, completion: nil)
            for subview in self.boardView.subviews {
                (subview as? UIButton)?.userInteractionEnabled = false
            }
            
        } else if gameState == .Tie  {
            let alert = UIAlertController (title:"Game Over!" , message: "Tie Game" , preferredStyle: UIAlertControllerStyle.Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                self.newGameButton.hidden = false
            })
            alert.addAction(dismiss)
            self.presentViewController(alert, animated: true, completion: nil)
            for subview in self.boardView.subviews {
                (subview as? UIButton)?.userInteractionEnabled = false
            }
        }
    }
    
    func restartGame() {
        for subview in boardView.subviews {
            (subview as? UIButton)?.setTitle("", forState: .Normal)
            (subview as? UIButton)?.userInteractionEnabled = true
        }
        myGameController.restartGame()
    }
    
    
    
    
    
}

