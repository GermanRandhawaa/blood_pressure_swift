//
//  NewReadingView.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//

import Foundation
import SwiftUI

struct NewReadingView: View {
    @StateObject var viewModel = NewReadingViewViewModel()
    @Binding var newReadingPresented: Bool
    @State var systolic : String = ""
    @State var diasystolic : String = ""
    
    
    var body: some View {
        VStack {
            // title
            Text("New pressure reading")
                .font(.largeTitle)
                .bold()
                .padding(.top, 100)
            // form to capture reading and member
            Form {
                // Member
                Picker("Member", selection: $viewModel.member) {
                    Text("father@home.com").tag("father@home.com")
                    Text("mother@home.com").tag("mother@home.com")
                    Text("grandma@home.com").tag("grandma@home.com")
                    Text("grandpa@home.com").tag("grandpa@home.com")
                }
                
                // Systolic
                TextField("Systolic", text: $systolic)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
                
                // Diastolic
                TextField("Diastolic", text: $diasystolic)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
                
                // Button
                Button("Save") {
                    print(viewModel.systolic)
                    print(viewModel.diastolic)
                    viewModel.systolic = Int(systolic) ?? -1
                    viewModel.diastolic = Int(diasystolic) ?? -1
                    print(viewModel.systolic)
                    print(viewModel.diastolic)
                    viewModel.save()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(""), message: Text(viewModel.errMsg))
            }
        }
    }
}

struct NewReadingView_Previews: PreviewProvider {
    static var previews: some View {
        NewReadingView(newReadingPresented: .constant(true))
    }
}
