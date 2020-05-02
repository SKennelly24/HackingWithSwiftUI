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
    @State private var isGameActive = false
    @State private var allQuestions = Array<Question>()
    @State private var chosenQuestions = Array<Question>()
    @State private var currentQuestion = 0
    @State private var answers = []
    @State private var answer = ""
    @State private var score = 0
    @State private var showingAlert = false
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
            .navigationBarTitle("Multiplication Game")
            .navigationBarItems(trailing:
                Button(action: startGame) {
                    Text("Start Game")
                }
            )
        }
    }
    
    func startGame() {
        isGameActive = true
        for i in 1...multiplier {
            for j in 1...multiplier {
                self.allQuestions.append(Question(multiplierA: i, multiplierB: j, answer: i*j))
            }
        }
        self.chosenQuestions = self.findRandomQuestions()
    }
    
    func findRandomQuestions() -> Array<Question> {
        var questions = Array<Question>()
        var count = 0
        if self.numQuestionsList[self.numQuestions] == 100 {
            count = self.allQuestions.count
        } else {
            count = self.numQuestionsList[self.numQuestions]
        }
        
        for _ in 0...count {
            let timeTableIndex = Int.random(in: 0...(self.allQuestions.count-2))
            let timeTable = self.allQuestions.remove(at: timeTableIndex)
            questions.append(timeTable)
        }
        
        return questions
    }
    
    func gameScreen() -> some View {
        NavigationView {
            Form {
                VStack {
                    Text("\(self.chosenQuestions[self.currentQuestion].multiplierA) X \(self.chosenQuestions[self.currentQuestion].multiplierB)")
                    TextField("Answer", text:$answer)
                    Button(action: nextQuestion) {
                        Text("Next")
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Finished Game"), message: Text("Your score was \(self.score)"), dismissButton: .default(Text("Play again")) {
                    self.isGameActive = false
                    self.score = 0
                })
            }
        }
    }
    
    func nextQuestion() {
        if (Int(answer) ?? 0 == self.chosenQuestions[self.currentQuestion].answer) {
            self.score += 1
        }
        if (self.currentQuestion < (self.chosenQuestions.count-2)) {
            self.currentQuestion += 1
        } else {
            self.showingAlert = true
            self.currentQuestion = 0
            self.allQuestions.removeAll()
            
        }
        
    }
    
    struct Question {
        var multiplierA : Int
        var multiplierB : Int
        var answer : Int
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
