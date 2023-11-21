//
//  SingleReadingView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//
//
//import Foundation
//import SwiftUI
//
//struct SingleReadingView: View {
//    let reading: Reading
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Systolic: \(reading.Systolic)")
//            Text("Diastolic: \(reading.Diastolic)")
//            Text("Condition: \(reading.Condition)")
//                .foregroundColor(conditionColor)
//            Text("Date: \(Date().timeIntervalSince1970)")
//        }
//        .padding()
//    }
//    
//    private var conditionColor: Color {
//        switch reading.Condition {
//        case "Normal":
//            return .green
//        case "Prehypertension":
//            return .orange
//        case "Hypertension Stage 1":
//            return .red
//        case "Hypertension Stage 2":
//            return .red
//        default:
//            return .black
//        }
//    }
//}
//
//struct SingleReadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleReading = Reading(Condition: "Normal", Diastolic: 80, Systolic:120, id: "1", readingDate : Date().timeIntervalSince1970)
//               
//        return SingleReadingView(reading: sampleReading)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
