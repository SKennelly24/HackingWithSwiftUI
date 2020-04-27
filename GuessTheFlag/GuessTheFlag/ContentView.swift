//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sarah Kennelly on 18/04/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = "0"
    @State private var message = ""
    @State private var animationAmount: Double = 0
    @State private var opacityAmount: Double = 1
    @State private var scaleAmount: CGFloat = 1
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing : 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action : {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                            .scaleEffect(number == self.correctAnswer ? 1 : self.scaleAmount)
                            .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                    }
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if (number == correctAnswer) {
            scoreTitle = "Correct"
            let int_score = Int(score) ?? 0
            score = String(int_score + 1)
            message = "Your score is \(score)"
            withAnimation {
                self.animationAmount += 360
                self.opacityAmount = 0.25
            }
        } else {
            scoreTitle = "Wrong"
            message = "That is the flag of \(countries[number])\n Your score is \(score)"
            withAnimation {
                self.scaleAmount = 0
            }
            
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.opacityAmount = 1
        self.animationAmount = 0
        self.scaleAmount = 1
    }
}

struct FlagImage: View {
    var image : String
    var body : some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
