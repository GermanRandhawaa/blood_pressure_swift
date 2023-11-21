//
//  ContentView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            NewReadingView(newReadingPresented: .constant(true))
                .tabItem {
                    Label("Main", systemImage: "1.circle")
                }
                .tag(0)

            Text("Readings List View")
                .tabItem {
                    Label("Readings", systemImage: "2.circle")
                }
                .tag(1)

            Text("Reports View")
                .tabItem {
                    Label("Reports", systemImage: "3.circle")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
