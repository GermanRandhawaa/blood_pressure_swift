//
//  ReadingsListViewModel.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//

import Foundation
import FirebaseFirestore

class ReadingsListViewModel: ObservableObject {
    @Published var readings: [Reading] = []
    
    func fetchReadings() {
        let db = Firestore.firestore()
        db.collection("Readings").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let documents = snapshot?.documents {
                    self.readings = documents.compactMap { document in
                        let documentData = document.data()
                        if let member = documentData["Member"] as? String,
                           let condition = documentData["Condition"] as? String,
                           let diastolic = documentData["Diastolic"] as? Int,
                           let systolic = documentData["Systolic"] as? Int,
                           let readingDate = documentData["readingDate"] as? TimeInterval {
                            return Reading(
                                Member: member,
                                Condition: condition,
                                Diastolic: diastolic,
                                Systolic: systolic,
                                id: document.documentID,
                                readingDate: readingDate
                            )
                        } else {
                            return nil
                        }
                    }
                }
            }
        }
    }
    
    func deleteReading(withID id: String) {
        let db = Firestore.firestore()
        db.collection("Readings").document(id).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                // If the deletion from Firestore was successful, update the local data
                self.readings.removeAll { $0.id == id }
            }
        }
    }
}
