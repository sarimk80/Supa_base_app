//
//  ContentView.swift
//  Supa_base_app
//
//  Created by sarim khan on 13/09/2023.
//

import SwiftUI
import Supabase

struct ContentView: View {
    
    @EnvironmentObject private var authViewModel : AuthViewModel
    @EnvironmentObject private var navigationViewModel : NavigationViewModel
    
    var body: some View{
        Group{
            switch (authViewModel.authState) {
            case .Initial:
                Text("Loading")
            case .Signin:
                HomeView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationViewModel)
            case .Signout:
                LoginView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationViewModel)
            }
        }
        .task {
            await authViewModel.isUserSignIn()
            
        }

    }

}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(NavigationViewModel())
}
