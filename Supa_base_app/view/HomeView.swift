//
//  HomeView.swift
//  Supa_base_app
//
//  Created by sarim khan on 15/09/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM : AuthViewModel
    @EnvironmentObject var navigationVM : NavigationViewModel
    var body: some View {
        NavigationStack(path: $navigationVM.authPath) {
            VStack{
                Text("Home")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                HStack{
                    Image(systemName: "cross.circle.fill")
                    Text("Logout")
                }
                .onTapGesture {
                    print("Clicked")
                    Task {
                        await authVM.signoutUser()
                    }
                }
            })
        }
        
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
   
}
