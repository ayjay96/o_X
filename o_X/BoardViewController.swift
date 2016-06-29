//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    // Create additional IBOutlets here.
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
    }
    
    
     // Create additional IBActions here.
    @IBAction func buttonPressed(sender: UIButton) {
        print("Hello World" + String(sender.tag))
        
        
    }

}



