//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Sarah Kennelly on 16/04/20.
//  Copyright © 2020 Sarah Kennelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var convertFromIndex = 0
    @State private var convertFromAmount = ""
    @State private var convertToIndex = 1
    private var convertedAmount : Double {
        let converted = Double(convertFromAmount) ?? 0
        if (converted != 0) {
            if (convertFromIndex == 0 && convertToIndex == 1) {
                return FahrenheittoCelsius(convertNum: converted)
            } else if (convertFromIndex == 0 && convertToIndex == 2){
                let celsius = FahrenheittoCelsius(convertNum: converted)
                return CelsiustoKelvin(convertNum: celsius)
            } else if (convertFromIndex == 1 && convertToIndex == 0) {
                return CelsiusToFahrenheit(convertNum: converted)
            } else if (convertFromIndex == 1 && convertToIndex == 2) {
                return CelsiustoKelvin(convertNum: converted)
            } else if (convertFromIndex == 2 && convertToIndex == 0) {
                let celsius = KelvinToCelsius(convertNum: converted)
                return CelsiusToFahrenheit(convertNum: celsius)
            } else {
                return KelvinToCelsius(convertNum: converted)
            }
        } else {
            return 0
        }
    }
    
    
    let temperatureUnits = ["Fahrenheit", "Celsius", "Kelvin"]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert From")) {
                    Picker("Choose Unit", selection: $convertFromIndex) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text(verbatim: "\(self.temperatureUnits[$0])")
                        }
                    }
                    TextField("Amount", text: $convertFromAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Convert To")) {
                    Picker("Choose Unit", selection: $convertToIndex) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text(verbatim: "\(self.temperatureUnits[$0])")
                        }
                    }
                }
                
                Section(header: Text("Converted Value")) {
                    Text("\(convertedAmount, specifier: "%.0f")")
                    
                }
            }
        }
        
    }
}

func FahrenheittoCelsius(convertNum : Double) -> Double{
    return (convertNum - 32) * 5/9
}

func CelsiusToFahrenheit(convertNum : Double) -> Double {
    return (convertNum * 9/5) + 32
}

func CelsiustoKelvin(convertNum : Double) -> Double {
    return (convertNum + 273.15)
}

func KelvinToCelsius(convertNum : Double) -> Double {
    return (convertNum - 273.15)
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
