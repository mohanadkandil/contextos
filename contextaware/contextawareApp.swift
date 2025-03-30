//
//  contextawareApp.swift
//  contextaware
//
//  Created by Mohanned Kandil on 28/03/2025.
//

import SwiftUI
import SwiftData

@main
struct contextawareApp: App {
    @StateObject private var appState = AppState()
    

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
