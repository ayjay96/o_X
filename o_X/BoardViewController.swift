//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    
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

    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        let storyboard = UIStoryboard (name: "Onboarding" , bundle: nil)
        
        let viewController = storyboard.instantiateInitialViewController()
        
        let application = UIApplication.sharedApplication()
        
        let window = application.keyWindow
        
        window?.rootViewController = viewController
        
    }
    
    
    // Create additional IBActions here.
    @IBAction func boardButtonPressed(sender: UIButton) {
        
        let cellType = myGameController.playMove(sender.tag)
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

