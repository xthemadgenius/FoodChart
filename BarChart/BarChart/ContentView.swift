//
//  ContentView.swift
//  BarChart
//
//  Created by Javier Calderon Jr. on 12/29/19.
//  Copyright © 2019 RockefellerFiles. All rights reserved.
//

import SwiftUI

struct DayDataPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: CGFloat
}

struct ContentView: View {
    
    static let data: [DayDataPoint] = [
        .init(day: "Su", value: 0.5),
        .init(day: "M", value: 0.5),
        .init(day: "T", value: 0.6),
        .init(day: "W", value: 0.8),
        .init(day: "TH", value: 0.7),
        .init(day: "F", value: 0.4),
        .init(day: "Sa", value: 1.0),
    ]
    
    static let afternoonData: [DayDataPoint] = [
        .init(day: "Su", value: 0.1),
        .init(day: "M", value: 0.2),
        .init(day: "T", value: 0.2),
        .init(day: "W", value: 0.8),
        .init(day: "TH", value: 0.3),
        .init(day: "F", value: 0.9),
        .init(day: "Sa", value: 0.7),
    ]
    
    static let eveningData: [DayDataPoint] = [
        .init(day: "Su", value: 0.9),
        .init(day: "M", value: 0.4),
        .init(day: "T", value: 0.1),
        .init(day: "W", value: 0.3),
        .init(day: "TH", value: 0.7),
        .init(day: "F", value: 1.0),
        .init(day: "Sa", value: 0.9),
    ]
    
    @State var dataSet = [
        data, afternoonData, eveningData
    ]
    
    var spacing: CGFloat = 24
    
    @State var selectedTime = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.sRGB, red: 12/255, green: 142/255, blue: 150/255, opacity: 1)
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 16) {
                    Spacer()
                    Text("Food Intake")
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 14/255, green: 55/255, blue: 122/255))
                        .padding(.bottom, 0)
                    
                    Picker(selection: self.$selectedTime, label: Text("What is your favorite color?")) {
                        Text("Weekday").tag(0)
                        Text("Afternoon").tag(1)
                        Text("Evening").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    HStack (spacing: self.spacing) {
                        // WARNING: Don't use a ForEach here, it doesn't animate.
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][0], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][1], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][2], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][3], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][4], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][5], width: (geometry.size.width - 8 * self.spacing) / 7)
                        StackedBarView(dataPoint: self.dataSet[self.selectedTime][6], width: (geometry.size.width - 8 * self.spacing) / 7)
                    }.animation(.default)
                    Spacer()
                }
            }
        }
    }
}

struct StackedBarView: View {
    var dataPoint: DayDataPoint
    var width: CGFloat
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                Capsule()
                    .frame(width: width, height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 20).fill(Color(.sRGB, red: 70/255, green: 201/255, blue: 144/255)))
                Capsule()
                    .frame(width: width, height: dataPoint.value * 200)
                    .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                
            }.padding(.bottom, 8)
            Text(dataPoint.day)
                .font(.system(size: 14))
        }
        
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
