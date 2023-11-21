//
//  NewReadingViewViewModel.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewReadingViewViewModel: ObservableObject {
    @Published var member = ""
    @Published var systolic = 0
    @Published var diastolic = 0
    @Published var errMsg = ""
    @Published var showAlert = false
    @Published var condition = ""
    
    init() { }
    
    func save() {
        guard !member.isEmpty else {
            errMsg = "Please select a member."
            showAlert = true
            return
        }

        guard systolic >= 0 && diastolic >= 0 else {
            errMsg = "Please enter valid systolic and diastolic readings."
            showAlert = true
            return
        }
        
        var condition: String
        if systolic < 120 && diastolic < 80 {
            condition = "Normal"
        } else if systolic >= 120 && systolic < 130 && diastolic < 80 {
            condition = "Elevated"
        } else if (systolic >= 130 && systolic < 140 && diastolic < 90) || (systolic < 140 && diastolic >= 80 && diastolic <= 89) {
            condition = "High blood pressure (stage 1)"
        } else if (systolic >= 140 && diastolic < 90) || (systolic >= 130 && diastolic >= 90) {
            condition = "High blood pressure (stage 2)"
        } else if systolic >= 180 || diastolic >= 120 {
            condition = "Hypertensive Crisis"
        } else {
            condition = "Undefined"
        }

        let newGuid = UUID().uuidString
        
        let newReading = Reading(
            Member : member,
            Condition: condition,
            Diastolic: diastolic,
            Systolic: systolic,
            id: newGuid,
            readingDate: Date().timeIntervalSince1970
        )

        // save the model
        let db = Firestore.firestore()
        db.collection("Readings")
            .document(newGuid)
            .setData(newReading.asDictionary()) { error in
                if let error = error {
                    self.errMsg = "Failed to save: \(error.localizedDescription)"
                } else {
                    self.errMsg = "Reading saved successfully!"
                }
                self.showAlert = true
                self.condition = newReading.Condition
        }
    }

}
