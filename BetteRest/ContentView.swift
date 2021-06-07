//
//  ContentView.swift
//  BetteRest
//
//  Created by administrator on 06/06/2021.
//

import SwiftUI

struct ContentView: View {
	@State private var wakeUpTime = Date()
	@State private var sleepHour = 8.00
	@State private var coffeNum = 0
	
	@State private var alertTitle = "Bed Time"
	@State private var alertMessage = ""
	@State private var showAlert = false
    var body: some View {
		NavigationView{
			ZStack{
				Form{
					VStack{
						Text("Wake Up Time")
							.font(.headline)
						
						DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
							.labelsHidden()
							.datePickerStyle(WheelDatePickerStyle())
							
					}
					
					Spacer()
					
					VStack{
						Text("Sleep Hours \(sleepHour, specifier: "%g")")
							.font(.headline)
						
						Stepper("", value: $sleepHour, in: 4...12, step: 0.50)
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
			.navigationBarItems(trailing: Button(action: tappedCaculate, label: {
				Text("Calculate")
			})
			.alert(isPresented: $showAlert){
				Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
			}
			)
		}
		
    }
	func tappedCaculate(){
		let model = BetterRest()
		let hourAndMinitue = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
		let hour = hourAndMinitue.hour ?? 0
		let minitue = hourAndMinitue.minute ?? 0
		let time = (hour * 60 * 60) + (minitue * 60)
		do {
		
			let prediction = try model.prediction(wake: Double(time), coffee: Double(coffeNum), actualSleep: sleepHour)
			let sleepTime = wakeUpTime - prediction.estimatedSleep
			let formatter = DateFormatter()
			formatter.timeStyle = .short
			let bedTime = formatter.string(from: sleepTime)
			self.alertMessage = "\(bedTime)"
		}
		
		catch{
			let sleepTime = Date()
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			let bedTime = formatter.string(from: sleepTime)
			self.alertMessage = "\(bedTime)"
		}
		self.showAlert = true
		
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
