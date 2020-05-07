//
//  ContentView.swift
//  iExpense
//
//  Created by Sarah Kennelly on 7/05/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}


struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

       var body: some View {
           Button("Save User") {
               let encoder = JSONEncoder()

               if let data = try? encoder.encode(self.user) {
                   UserDefaults.standard.set(data, forKey: "UserData")
               }
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
