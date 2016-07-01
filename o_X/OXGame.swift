//
//  OXGame.swift
//  o_X
//
//  Created by avarn127 on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {
    private var board = [CellType](count: 9 , repeatedValue: CellType.Empty)
    private var startType: CellType = CellType.X
    
    func turnCount() -> Int {
        return board.filter({ $0 != .Empty }).count
    }
    
    func whoseTurn() -> CellType {
        if turnCount() % 2 == 0 {
            return startType
        } else {
            if startType == .X {
                return .O
            } else {
                return .X
            }
        }
        
    }
    
    func playMove(cell: Int) -> CellType {
        board[cell] = whoseTurn()
        return board[cell]
    }
    func gameWon() -> Bool {
        if (board[0] == board[1] && board[1] == board[2] && board[2] != .Empty) ||
        (board[3] == board [4] && board[4] == board[5] && board[5] != .Empty) ||
        (board[6] == board [7] && board[7] == board[8] && board[8] != .Empty) ||
        (board[0] == board [3] && board[3] == board[6] && board[6] != .Empty) ||
        (board[1] == board [4] && board[4] == board[7] && board[7] != .Empty) ||
        (board[2] == board [5] && board[5] == board[8] && board[8] != .Empty) ||
        (board[0] == board [4] && board[4] == board[8] && board[8] != .Empty) ||
        (board[2] == board [4] && board[4] == board[6] && board[6] != .Empty){
            return true
        }
        return false
    }

    func state() -> OXGameState {
        if (self.gameWon()){
            return .Won
        }
        else if turnCount() == 9 {
            return .Tie
        }
        return OXGameState.InProgress
        
    
    }
    
    func reset() {
        board = [CellType](count: 9 , repeatedValue: CellType.Empty)
    }
    
}

enum CellType: String {
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState {
    case InProgress
    case Tie
    case Won
}