//
//  ReportsViewe.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//
import Foundation
import SwiftUI

struct ReportsView: View {
    @StateObject var viewModel = ReportsViewModel()

    var body: some View {
        VStack {
            Text("Month-to-date average readings for Nov 2022")
                .font(.title)
                .padding()

            ForEach(viewModel.averageReadings.sorted(by: { $0.key < $1.key }), id: \.key) { member, readings in
                VStack(alignment: .leading) {
                    Text("Family member: \(member)")
                        .font(.headline)
                    Text("Systolic Reading: \(String(format: "%.2f", readings.0))")
                    Text("Diastolic Reading: \(String(format: "%.2f", readings.1))")
                    Text("Average Condition: \(readings.2)")
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchMonthToDateAverages()
        }
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ReportsViewModel()
        viewModel.averageReadings = [
            "father@home.com": (135.32, 81.65, "High blood pressure (stage 1)"),
            "mother@home.com": (125.5, 75.6, "High blood pressure (Elevated)")
        ]
        
        return ReportsView(viewModel: viewModel)
    }
}
