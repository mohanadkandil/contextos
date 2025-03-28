//
//  Item.swift
//  contextaware
//
//  Created by Mohanned Kandil on 28/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
