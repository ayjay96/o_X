//
//  OXGameController.swift
//  o_X
//
//  Created by avarn127 on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameController {
    static let sharedInstance = OXGameController()
    private init() {
    var ID: Int
    var host: String
    
    } //This prevents others from using the default '()' initializer for this class.
    
    private var currentGame = OXGame()
    
    
    func getCurrentGame () -> OXGame {
        return currentGame
    }
    
    func restartGame() -> OXGame {
        self.currentGame.reset()
        return currentGame
    }
    
    func playMove(position:Int) -> OXGame.CellType {
        return currentGame.playMove(position)
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        return onCompletion ([], "data")
    }

}