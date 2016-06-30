//
//  OXGame.swift
//  o_X
//
//  Created by avarn127 on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {
    private var board = [CellType] (count: 9 , repeatedValue: CellType.Empty)
    private var startType: CellType = CellType.X
    
    func turnCount() -> Int {
        return board.filter({ $0 != .Empty }).count
    }
    func whoseTurn() -> CellType{
        
            
        }
            
        
    }
    
}

enum CellType: String {
    
    case O = "O" ; case X = "X" ; case Empty = ""
}

enum OXGameState {
    
    case InProgress ; case Tie ; case Won
}