//
//  ContentView.swift
//  AnimationTechnique
//
//  Created by Sarah Kennelly on 26/04/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        
        
    }
}

/*
 Red button with scaling circle forever code
 Button("Tap Me") {
     // self.animationAmount += 1
 }
 .padding(40)
 .background(Color.red)
 .foregroundColor(.white)
 .clipShape(Circle())
 .overlay(
     Circle()
         .stroke(Color.red)
         .scaleEffect(animationAmount)
         .opacity(Double(2 - animationAmount))
         .animation(
             Animation.easeOut(duration: 1)
                 .repeatForever(autoreverses: false)
         )
 )
 .onAppear {
     self.animationAmount = 2
 }
 */

/* Scaling Button and animating the changes
 print(animationAmount)
 return VStack {
     Stepper("Scale amount", value: $animationAmount.animation(
         Animation.easeInOut(duration: 1)
             .repeatCount(3, autoreverses: true)
     ), in: 1...10)
     
     Spacer()
     
     Button("Tap Me"){
         self.animationAmount += 1
     }
     .padding(40)
     .background(Color.red)
     .foregroundColor(.white)
     .clipShape(Circle())
     .scaleEffect(animationAmount)
 }*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
