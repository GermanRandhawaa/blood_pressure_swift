//
//  SingleItemViewModel.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//

import Foundation
import FirebaseFirestore

class SingleReadingViewModel: ObservableObject {
    @Published var reading: Reading

    init(reading: Reading) {
        self.reading = reading
    }

    func updateReading(member: String, diastolic: Int, systolic: Int) {
        let db = Firestore.firestore()

        // Calculate condition based on systolic and diastolic values
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

        db.collection("Readings").document(reading.id).updateData([
            "Member": member,
            "Diastolic": diastolic,
            "Systolic": systolic,
            "Condition": condition
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
                DispatchQueue.main.async {
                    self.reading = Reading(Member: member, Condition: condition, Diastolic: diastolic, Systolic: systolic, id: self.reading.id, readingDate: self.reading.readingDate)
                }
            }
        }
    }


}
