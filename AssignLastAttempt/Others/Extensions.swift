//
//  Extensions.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//

import Foundation

extension Encodable {
   func asDictionary() -> [String: Any] {
      guard let data = try? JSONEncoder().encode(self) else {
         return [:]
      }
      
      do {
         let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
         return json ?? [:]
      } catch {
         return [:]
      }
               
   }
}
