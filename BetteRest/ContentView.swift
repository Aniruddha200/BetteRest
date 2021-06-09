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
	
	private var sleepAt: String{
		self.tappedCaculate()
	}
	
    var body: some View {
		
			NavigationView{
				ZStack{
					
					RadialGradient(gradient: Gradient(colors: [Color.white, Color("backGroundColor")]), center: .topLeading, startRadius: 0, endRadius: 1600)
					
					VStack{
						
						Spacer()
						Section(header: Text("Sleep At")
									.font(.headline)
									.foregroundColor(.black)
									.padding()
						){
							Text("\(sleepAt)")
								.font(.title)
								.offset(x:0, y:0)
						}
						.offset(x:0, y: -80)
						
						
						Section(header: Text("Wake Up Time")
									.font(.headline)
									.foregroundColor(.black)
									.offset(x: 0, y: 10)
						){
							
							
							DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
								.labelsHidden()
								.datePickerStyle(WheelDatePickerStyle())
							
						}
						.offset(y: -30)
						
						HStack(spacing: 80){
							
							VStack{
								Text("Coffees Intake: \(coffeNum)")
											.font(.headline)
								Stepper("", value: $coffeNum, in: 0...10)
									.labelsHidden()
							}
						
							VStack{
								Text("Sleep Hours: \(sleepHour, specifier: "%g")")
											.font(.headline)
								Stepper("", value: $sleepHour, in: 1...12)
									.labelsHidden()
							}
						
						
						}
						
						Spacer()
						
					}
					
				}
				.navigationBarTitle("Better Rest", displayMode: .inline)
				
			}
		
    }
	func tappedCaculate() -> String{
		let model = BetterRest1()
		let hourAndMinitue = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
		let hour = hourAndMinitue.hour ?? 0
		let minitue = hourAndMinitue.minute ?? 0
		let time = (hour * 60 * 60) + (minitue * 60)
		var result: String
		var sleepTime: Date
		var formatter: DateFormatter
		var prediction: BetterRest1Output
		do {
		
			prediction = try model.prediction(wake: Double(time), estimatedSleep: sleepHour, coffee: Double(coffeNum))
			sleepTime = wakeUpTime - prediction.actualSleep
			formatter = DateFormatter()
			formatter.timeStyle = .short
			result = formatter.string(from: sleepTime)
		}
		
		catch{
			result = "Unknown"
		}
		
		
		
		return result
		
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
