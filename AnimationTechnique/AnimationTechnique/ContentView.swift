//
//  ContentView.swift
//  AnimationTechnique
//
//  Created by Sarah Kennelly on 26/04/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height:200)
                    .transition(.pivot)
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount : Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
    
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor:.topLeading), identity: CornerRotateModifier(amount: 0, anchor:.topLeading))
    }
}
/* Tap and rectangle appears and dissapears
 @State private var isShowingRed = false
 
 var body: some View {
     VStack {
         Button("Tap me") {
             withAnimation {
                 self.isShowingRed.toggle()
             }
         }
         
         if isShowingRed {
             Rectangle()
                 .fill(Color.red)
                 .frame(width: 200, height:200)
                 .transition(.asymmetric(insertion: .scale, removal: .opacity))
         }
     }
 }*/

/* Hello SwfitUI where all the letters animate differently
 struct ContentView: View {
     let letters = Array("Hello SwiftUI")
     @State private var enabled = false
     @State private var dragAmount = CGSize.zero
     
     var body: some View {
         HStack(spacing: 0) {
             ForEach(0..<letters.count) { num in
                 Text(String(self.letters[num]))
                     .padding(5)
                     .font(.title)
                     .background(self.enabled ? Color.blue : Color.red)
                     .offset(self.dragAmount)
                     .animation(Animation.default.delay(Double(num) / 20))
             }
         }
         .gesture(
             DragGesture()
                 .onChanged { self.dragAmount = $0.translation}
                 .onEnded { _ in
                     self.dragAmount = .zero
                     self.enabled.toggle()
                     
                 }
         )
     }
 }
 */

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

/* Red button flipping
 Button("Tap Me") {
    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
             self.animationAmount += 360
         }
 }
 .padding(50)
 .background(enabled ? Color.blue : Color.red)
 .foregroundColor(.white)
 .clipShape(Circle())
 .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
 */

/*Multiple animations
 Button("Tap Me") {
     self.enabled.toggle()
 }
 .frame(width: 200, height: 200)
 .background(enabled ? Color.blue : Color.red)
 .animation(.default)
 .foregroundColor(.white)
 .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
 .animation(.interpolatingSpring(stiffness: 10, damping: 1))
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
