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
        db.collection("Readings")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to fetch readings: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No readings found")
                    return
                }
                
                let readings = documents.compactMap { document -> Reading? in
                    let data = document.data()
                    let condition = data["Condition"] as? String ?? ""
                    let diastolic = data["Diastolic"] as? Int ?? 0
                    let systolic = data["Systolic"] as? Int ?? 0
                    let id = document.documentID
                    
                    return Reading(
                        Condition: condition,
                        Diastolic: diastolic,
                        Systolic: systolic,
                        id: id,
                        readingDate: 0 // Replace with the actual reading date value from the document
                    )
                }
                
                DispatchQueue.main.async {
                    self.readings = readings
                }
            }
    }
}
