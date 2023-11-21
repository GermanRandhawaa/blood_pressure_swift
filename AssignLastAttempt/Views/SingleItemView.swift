//
//  SingleItemView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//

import SwiftUI

struct SingleReadingView: View {
    @ObservedObject var viewModel: SingleReadingViewModel
    @State private var redirectToContentView = false
    @State private var diastolic: String
    @State private var systolic: String

    init(viewModel: SingleReadingViewModel) {
        self.viewModel = viewModel
        _diastolic = State(initialValue: "\(viewModel.reading.Diastolic)")
        _systolic = State(initialValue: "\(viewModel.reading.Systolic)")
    }

    var body: some View {
        Form {
            Section(header: Text("Member Details")) {
                Text("Member: \(viewModel.reading.Member)")
                    .disabled(true)
                Text("Condition: \(viewModel.reading.Condition)")
                    .disabled(true)
            }
            Section(header: Text("Reading Details")) {
                TextField("Diastolic", text: $diastolic)
                    .keyboardType(.numberPad)
                TextField("Systolic", text: $systolic)
                    .keyboardType(.numberPad)
            }
            Section {
                Button(action: {
                    viewModel.updateReading(member: viewModel.reading.Member,
                                            diastolic: Int(diastolic) ?? viewModel.reading.Diastolic,
                                            systolic: Int(systolic) ?? viewModel.reading.Systolic)
                    redirectToContentView = true
                }) {
                    Text("Update Reading")
                }
            }
        }
        .navigationTitle("Reading Details")
        .background(
            NavigationLink("", destination: ContentView(), isActive: $redirectToContentView)
                .isDetailLink(false) // To prevent back navigation
        )
    }
}


struct SingleReadingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleReadingView(viewModel: SingleReadingViewModel(reading: Reading(Member: "John Doe", Condition: "Normal", Diastolic: 80, Systolic: 120, id: "1", readingDate: Date().timeIntervalSince1970)))
    }
}
