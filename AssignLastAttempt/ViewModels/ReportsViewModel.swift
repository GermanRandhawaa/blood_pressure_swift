//
//  ReportsViewModel.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-21.
//

import Foundation
import FirebaseFirestore

class ReportsViewModel: ObservableObject {
    @Published var averageReadings: [String: (Double, Double, String)] = [:]

    func fetchMonthToDateAverages() {
        let db = Firestore.firestore()
        let readingsCollection = db.collection("Readings")
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())

        readingsCollection
            .whereField("readingDate", isGreaterThanOrEqualTo: TimeInterval(DateComponents(year: currentYear, month: currentMonth, day: 1).date?.timeIntervalSince1970 ?? 0))
            .whereField("readingDate", isLessThanOrEqualTo: TimeInterval(Date().timeIntervalSince1970))
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                var readingsDict: [String: [(Int, Int)]] = [:]

                for document in documents {
                    guard let member = document.data()["Member"] as? String,
                          let systolic = document.data()["Systolic"] as? Int,
                          let diastolic = document.data()["Diastolic"] as? Int else {
                        continue
                    }

                    if readingsDict[member] == nil {
                        readingsDict[member] = []
                    }

                    readingsDict[member]?.append((systolic, diastolic))
                }

                var averages: [String: (Double, Double, String)] = [:]

                for (member, readings) in readingsDict {
                    let systolicSum = readings.map { Double($0.0) }.reduce(0.0, +)
                    let diastolicSum = readings.map { Double($0.1) }.reduce(0.0, +)
                    let systolicAverage = systolicSum / Double(readings.count)
                    let diastolicAverage = diastolicSum / Double(readings.count)

                    let condition: String
                    switch (systolicAverage, diastolicAverage) {
                    case (..<120, ..<80):
                        condition = "Normal"
                    case (120..<130, ..<80):
                        condition = "Elevated"
                    case (130..<140, ..<90), (..<140, 80...89):
                        condition = "High blood pressure (stage 1)"
                    case (140..., ..<90), (130..., 90...):
                        condition = "High blood pressure (stage 2)"
                    case (180..., _), (_, 120...):
                        condition = "Hypertensive Crisis"
                    default:
                        condition = "Undefined"
                    }

                    averages[member] = (systolicAverage, diastolicAverage, condition)
                }

                DispatchQueue.main.async {
                    self.averageReadings = averages
                }
            }
    }
}
