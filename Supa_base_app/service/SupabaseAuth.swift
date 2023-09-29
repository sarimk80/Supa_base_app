//
//  SupabaseAuth.swift
//  Supa_base_app
//
//  Created by sarim khan on 25/09/2023.
//

import Foundation
import Combine
import Supabase


class SupabaseAuth {
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://afwqflulgakrxyhphlkk.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFmd3FmbHVsZ2Frcnh5aHBobGtrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzUxNDEyMjAsImV4cCI6MTk5MDcxNzIyMH0.VhJ9H1I1kbHrVnz2K2enGpqaYAjN3qf2IjnXefZvBHE")
    
    func LoginUser() async throws {
        do{
            let session = try await client.auth.session
            
        }catch let error{
            throw error
        }
    }
    
    func SignIn(email:String,password:String) async throws {
        do{
            try await client.auth.signIn(email: email.lowercased(), password: password)
        }catch let error{
            throw error
        }
    }
    
    
    func SignUp(email:String,password:String) async throws{
        do{
            try await client.auth.signUp(email: email.lowercased(), password: password)
        }catch let error{
            throw error
        }
    }
    
    func signOut() async throws{
        do{
            try await client.auth.signOut()
        }catch let error{
            throw error
        }
    }
}
