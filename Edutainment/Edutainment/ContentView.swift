//
//  ContentView.swift
//  Edutainment
//
//  Created by Sarah Kennelly on 1/05/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplier = 5
    let numQuestionsList = [5,10,20,100]
    @State private var numQuestions = 1
    @State private var isGameActive = true
    @State private var timeTables = []
    @State private var questionIndexes = Array<(String, Int)>()
    var body: some View {
        Group {
            if isGameActive {
                gameScreen()
            } else {
                startScreen()
            }
        }
    }
    
    func startScreen() -> some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Multiplication Tables up to")
                    Stepper(value: $multiplier, in: 1...12, step: 1) {
                        Text("\(multiplier)")
                    }
                }
                
                VStack{
                    Picker("Amount of Questions", selection: $numQuestions) {
                        ForEach(0 ..< numQuestionsList.count) {
                            if $0 == 3 {
                                    Text("All")
                            } else {
                                    Text("\(self.numQuestionsList[$0])")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Game Settings")
            .navigationBarItems(trailing:
                Button(action: self.startGame) {
                    Text("Start Game")
                }
            )
        }
    }
    
    func startGame() {
        isGameActive = true
        for i in 1...multiplier {
            for j in 1...multiplier {
                let table = "\(i) x \(j)"
                let timesTable = (tableString: table, answer: i*j)
                self.timeTables.append(timesTable)
            }
        }
        self.questionIndexes = findRandomQuestions()
    }
    
    func findRandomQuestions() -> Array<(String, Int)> {
        var questionTuples = [("", 40)]
        var count = 0
        if self.numQuestionsList[self.numQuestions] == 100 {
            count = self.timeTables.count
        } else {
            count = self.numQuestionsList[self.numQuestions]
        }
        
        for _ in 0...count {
            let timeTableIndex = Int.random(in: 0...self.timeTables.count)
            let timeTableTuple = self.timeTables.remove(at: timeTableIndex)
            questionTuples.append(timeTableTuple as! (String, Int))
        }
        
        return questionTuples
    }
    
    func gameScreen() -> some View {
        
        NavigationView {
            VStack {
                ForEach(0 ..< self.numQuestionsList[self.numQuestions]) { num in
                    Text("\(self.questionIndexes[num].0)")
                }
                
            }
        }
    }
    func generateQuestions() {
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
