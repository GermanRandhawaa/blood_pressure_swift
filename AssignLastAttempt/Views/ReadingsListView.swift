//
//  ReadingsListView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct ReadingsListView: View {
    
    @StateObject var viewModel = ReadingsListViewModel()
    @State private var selectedReading: Reading? // Track selected reading
    @State private var isSheetPresented = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy, h:mm a"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Banner") 
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                List {
                    ForEach(viewModel.readings) { reading in
                        VStack(alignment: .leading) {
                            Text("Member: \(reading.Member)")
                            Text("Condition: \(reading.Condition)")
                            Text("Systolic: \(reading.Systolic)")
                            Text("Diastolic: \(reading.Diastolic)")
                            Text("Date: \(dateFormatter.string(from: Date(timeIntervalSince1970: reading.readingDate)))")
                        }
                        .onTapGesture {
                            selectedReading = reading
                            isSheetPresented = true
                        }
                        .background(Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1)))
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let readingToDelete = viewModel.readings[index]
                            viewModel.deleteReading(withID: readingToDelete.id)
                        }
                    }
                }
                .navigationTitle("Reading Pressure")
                .onAppear {
                    viewModel.fetchReadings()
                }
            }
        }
        .sheet(item: $selectedReading) { reading in
            SingleReadingView(viewModel: SingleReadingViewModel(reading: reading))
        }
        .onDisappear {
            viewModel.fetchReadings() // Fetch data on sheet close
        }
    }
}

struct ReadingsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingsListView()
    }
}
