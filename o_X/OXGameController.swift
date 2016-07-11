//
//  OXGameController.swift
//  o_X
//
//  Created by avarn127 on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameController: WebService {
    static let sharedInstance = OXGameController()
    private override init() {
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
    //get games from server
    func getGameList (onCompletion: ([OXGame]? , String? )-> Void){
        print("here is client")
        print(UserController.sharedInstance.currentUser!.client)
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print (json)
          
            // if server likes what just happened do this shit
            if (responseCode == 200){
                //list of OXgames I will send to my table view
                var oxGameList = [OXGame]()
                
                //iterate through the json aray and for each game, add it to the list of games I will return
                for (_,subJson) in json {
                    var newOxGame = OXGame()
                    newOxGame.ID = subJson ["id"].intValue
                    newOxGame.host = subJson ["host_user"]["uid"].stringValue
                    oxGameList.append(newOxGame)
                }
                
                // run the on Completion closure: give the games to the table view controller
                onCompletion(oxGameList,nil)
            }
            // if my server hates my shit, throw this shit at me
            else{
                let errorMessage = json ["error"]["full_messages"][0].stringValue
                onCompletion(nil, errorMessage)
            }
            
            
        })
    
    }
    func joinGame(id:Int, onCompletion: (OXGame?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)/join"), method: "GET", parameters: nil)
        
        self.executeRequest(request) {(responseCode, json) in
        if (responseCode == 200)   {
            print("joined game id: \(json["id"].intValue)")
            var newgame = OXGame()
            newgame.ID = json ["id"].intValue
            newgame.host = json ["host_use"]["email"].stringValue
            self.currentGame = newgame
            onCompletion (newgame, nil)
        
                
              
            }
        }
        

    
}
    
    func playMove(id:Int, onCompletion: (String?) -> Void) {
        var board = self.getCurrentGame().serialiseBoard()
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "PUT", parameters: ["board": board])
        
        self.executeRequest(request) {(responseCode, json) in
            if (responseCode == 200)   {
               onCompletion (nil)
            }
            else {
                onCompletion("Invalid Move")
            }
        }
    
}
    func createGame(id:Int, onCompletion: (OXGame?, String?) -> Void) {
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        self.executeRequest(request) {(responseCode, json) in
            if (responseCode == 200)   {
                var newgame = OXGame()
                newgame.ID = json ["id"].intValue
                newgame.host = json ["host_use"]["email"].stringValue
                onCompletion(newgame, nil)
                
                
            }
            else {
                onCompletion(nil, "Could not create game")
            }
        }
        
        
        
    }
    func cancelGame(id:Int, onCompletion: (String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "DELETE", parameters: nil)
        
        self.executeRequest(request) {(responseCode, json) in
            if (responseCode == 200)   {
                self.currentGame.reset()
            }
            else {
                let errorMessage = json ["error"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
                
            }
        }
        
    }
    
    func viewGame(id:Int, onCompletion: (String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(id)"), method: "GET", parameters: nil)
        
        self.executeRequest(request) {(responseCode, json) in
            if (responseCode == 200)   {
                var newboard = self.currentGame.deserialiseBoard(json["board"].stringValue)
                self.currentGame.board = newboard
                onCompletion(nil)
            }
            else {
                let errorMessage = json ["error"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
            }
        }
    
    
    
    
    
}
}

