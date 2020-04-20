//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sarah Kennelly on 20/04/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["rock", "paper", "scissors"]
    @State private var app_move_index = 0
    @State private var win = true
    @State private var score = 0
    @State private var player_move = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            VStack(spacing:60){
                Text(win ? "Try to win,\ncomputer played \(moves[app_move_index])" : "Try to lose,\ncomputer played \(moves[app_move_index])")
                    .foregroundColor(.white)
                    .font(.headline)
                
                VStack(spacing:10) {
                    ForEach(0 ..< moves.count) { number in
                        Button(action : {
                            self.moveTapped(number)
                        }) {
                            MoveText(text: self.moves[number])
                            }
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
    }
    
    func moveTapped(_ move_index: Int) {
        self.player_move = move_index
        if (didWin()) {
            score += 1
        }
        self.win = Bool.random()
        self.app_move_index = Int.random(in:0...2)
    }
    
    func didWin() -> Bool{
        let appMove = moves[app_move_index]
        let playerMove = moves[player_move]
        if (appMove == "Rock" && playerMove == "Scissors") {
            return false
        } else if (appMove == "Scissors" && playerMove == "Paper") {
            return false
        } else if (appMove == "Paper" && playerMove == "Rock") {
            return false
        } else {
            return true
        }
    }
}

struct MoveText: View {
    var text : String
    var body : some View {
        Text(text)
            .shadow(color: .black, radius: 1)
            .foregroundColor(.white)
            .font(.largeTitle)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
