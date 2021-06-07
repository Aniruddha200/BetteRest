//
//  ContentView.swift
//  BetteRest
//
//  Created by administrator on 06/06/2021.
//

import SwiftUI

struct ContentView: View {
	@State private var wakeUpTime = Date()
	@State private var slpeeHour = 8.00
	@State private var coffeNum = 0
    var body: some View {
		NavigationView{
			ZStack{
				Form{
					VStack{
						Text("Wake Up Time")
							.font(.headline)
						
						DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
							.labelsHidden()
					}
					
					Spacer()
					
					VStack{
						Text("The number is \(slpeeHour, specifier: "%g")")
							.font(.headline)
						
						Stepper("", value: $slpeeHour, in: 4...12, step: 0.50)
							.labelsHidden()
					}
					
					Spacer()
					
					VStack{
						Text("Coffe Intake \(coffeNum) cups")
							.font(.headline)
						
						Stepper("", value: $coffeNum, in: 0...10)
							.labelsHidden()
					}
					}
			}
			.navigationBarTitle("Better Rest", displayMode: .inline)
			.navigationBarItems(trailing: Button(action: {print("Haha")}, label: {
				Text("Calculate")
			}))
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
