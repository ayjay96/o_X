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
        }
        else {
            if startType == .X {
                return .O
            }
            else {
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
        board = [CellType](count: 9, repeatedValue: CellType.Empty)
    }
    
    func deserialiseBoard(boardString:String) -> [CellType] {
        var board = [CellType]()
        for char in boardString.characters {
            if char == "X" {
                board.append(CellType.X)
            }
            else if char == "O" {
                board.append(CellType.O)
            }
            else {
               board.append(CellType.Empty)
            }
        }
        return board
    }
    
    
    func serialiseBoard() -> String {
        var accum = ""
        for cell in board {
            if cell == CellType.X {
                accum = accum + "x"
            }
            else if cell == CellType.O {
                accum = accum + "o"
            }
            else {
                accum = accum + "_"
            }
        }
        return accum
    }
    
    
     init()  {
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "_________" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("start\n------------------------------------")
            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("done\n------------------------------------")
        }   else    {
            print("start\n------------------------------------")
            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("done\n------------------------------------")
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

}
