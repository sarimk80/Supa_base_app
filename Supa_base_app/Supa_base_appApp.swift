//
//  Supa_base_appApp.swift
//  Supa_base_app
//
//  Created by sarim khan on 13/09/2023.
//

import SwiftUI

@main
struct Supa_base_appApp: App {
    
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var navigationVM = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(navigationVM)
        }
    }
}
