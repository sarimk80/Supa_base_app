//
//  InitView.swift
//  Supa_base_app
//
//  Created by sarim khan on 25/09/2023.
//

import SwiftUI

struct InitView: View {
    @EnvironmentObject private var navigationVM : NavigationViewModel
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        VStack{
            Text("Loading")
        }
        .task {
          await authViewModel.isUserSignIn()
        }
        
        
    }
    
}

#Preview {
    InitView()
}
