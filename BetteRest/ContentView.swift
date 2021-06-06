//
//  ContentView.swift
//  BetteRest
//
//  Created by administrator on 06/06/2021.
//

import SwiftUI

struct ContentView: View {
	@State private var date = Date()
	@State private var number = 8.00
    var body: some View {
		return ZStack{
			LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),  Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea(.all)
			
			VStack(spacing: 50){
				Text("\(date)")
				
				DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
					.labelsHidden()
				
				Text("The number is \(number, specifier: "%.2f")")
				
				Stepper("", value: $number, in: 4...12, step: 0.50)
					.labelsHidden()
				Spacer()
				}
		}
		
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
