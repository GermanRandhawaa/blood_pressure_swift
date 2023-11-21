//
//  ContentView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//
import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var newReadingPresented = false
    @StateObject var readingsViewModel = ReadingsListViewModel() // Create the ViewModel
    @StateObject var reportsViewModel = ReportsViewModel() // Create the Reports ViewModel
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ReadingsListView()
                    .navigationBarItems(trailing: Button(action: {
                        newReadingPresented = true
                    }) {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $newReadingPresented) {
                        NewReadingView(newReadingPresented: $newReadingPresented)
                            .onDisappear {
                                readingsViewModel.fetchReadings() // Refresh readings on NewReadingView close
                            }
                    }
            }
            .tabItem {
                Label("Readings", systemImage: "book")
            }
            .tag(0)
            
            ReportsView(viewModel: reportsViewModel) // Navigate to ReportsView
                .tabItem {
                    Label("Reports", systemImage: "chart.bar")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
