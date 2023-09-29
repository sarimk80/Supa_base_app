//
//  NavigationViewModel.swift
//  Supa_base_app
//
//  Created by sarim khan on 15/09/2023.
//

import Foundation
import SwiftUI
import Combine

enum AuthRoute:String,Hashable{
    case Login
    case Signup
    case Home
}

class NavigationViewModel:ObservableObject{
    
    @Published var authPath = NavigationPath()
    
    
    func navigate(authRoute:AuthRoute)  {
        authPath.append(authRoute)
    }
    
    func popToRoot(){
        authPath.removeLast(authPath.count)
    }
    
    func pop()  {
        authPath.removeLast()
    }
    
}
