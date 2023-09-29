# 🌟 Seamless Authentication with SwiftUI & Supabase 🚪

## Introduction
In the ever-evolving world of app development, SwiftUI has emerged as a powerful framework for building user interfaces, while Supabase offers a feature-rich backend service. In this article, we'll explore how to create a secure authentication system in SwiftUI using Supabase.
## Prerequisites
Before we dive into the implementation, make sure you have the following prerequisites in place:
1. Xcode installed on your development machine.
2. A Supabase account for authentication.
3. Basic knowledge of SwiftUI and Swift programming.

## Setting Up Supabase
### Step 1: Sign Up for Supabase
If you haven't already, sign up for a Supabase account at https://supabase.io. Once you've registered, create a new project and note down your project URL and API key.
### Step 2: Configure Supabase
1. Next, we'll configure Supabase to create a user authentication system. In your Supabase project dashboard:
2. Go to Authentication > Settings and enable Email as a sign-in method.
3. In Email drop down disable Confirm Email.

## Building the SwiftUI App
1. Create a New SwiftUI Project
2. Open Xcode and create a new SwiftUI project. Name it "SwiftUISupabaseAuth."
3. Install Supabase Swift
4. In your Xcode project, go to File > Swift Packages > Add Package Dependency. Enter the URL for the Supabase Swift SDK: https://github.com/supabase/supabase-swift.git

### Introduction
In the ever-evolving world of app development, SwiftUI has emerged as a powerful framework for building user interfaces, while Supabase offers a feature-rich backend service. In this article, we'll explore how to create a secure authentication system in SwiftUI using Supabase.
Prerequisites
Before we dive into the implementation, make sure you have the following prerequisites in place:
1. Xcode installed on your development machine.
2. A Supabase account for authentication.
3. Basic knowledge of SwiftUI and Swift programming.

### Setting Up Supabase
1. Sign Up for Supabase
If you haven't already, sign up for a Supabase account at https://supabase.io. Once you've registered, create a new project and note down your project URL and API key.
2. Configure Supabase
Next, we'll configure Supabase to create a user authentication system. In your Supabase project dashboard:
Go to Authentication > Settings and enable Email as a sign-in method.
In Email drop down disable Confirm Email.

Building the SwiftUI App
Create a New SwiftUI Project
Open Xcode and create a new SwiftUI project. Name it "SwiftUISupabaseAuth."
Install Supabase Swift
In your Xcode project, go to File > Swift Packages > Add Package Dependency. Enter the URL for the Supabase Swift SDK: https://github.com/supabase/supabase-swift.git

## Auth service class:
```
class SupabaseAuth {
    
    let client = SupabaseClient(supabaseURL: URL(string: "Your url")!, supabaseKey: "your key")
    
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
```
## Initialization
The SupabaseAuth class is initialized with a SupabaseClient instance. The SupabaseClient is a Swift client library provided by Supabase, configured with your Supabase project's URL and API key.
let client = SupabaseClient(supabaseURL: URL(string: "https://your-supabase-project-url.supabase.co")!, supabaseKey: "your-api-key")
let supabaseAuth = SupabaseAuth(client: client)
### Authentication Methods
#### 1. func LoginUser() async throws
The LoginUser method retrieves the current session of the authenticated user. It's a useful method to check if a user is already logged in without triggering a login process.
```
do {
    let session = try await supabaseAuth.LoginUser()
    // Handle user session
} catch let error {
    // Handle error
}
```
#### 2. func SignIn(email: String, password: String) async throws
The SignIn method allows a user to sign in with their email and password.
Parameters:
email: The user's email address.
password: The user's password.
```
do {
    try await supabaseAuth.SignIn(email: "user@example.com", password: "password123")
    // User is signed in
} catch let error {
    // Handle sign-in error
}
```
#### 3. func SignUp(email: String, password: String) async throws
The SignUp method allows a user to create a new account with their email and password.
Parameters:
email: The user's email address.
password: The user's password.
```
do {
    try await supabaseAuth.SignUp(email: "newuser@example.com", password: "newpassword123")
    // User account created
} catch let error {
    // Handle sign-up error
}
```
#### 4. func SignOut() async throws
The SignOut method allows the currently authenticated user to sign out.
```
do {
    try await supabaseAuth.SignOut()
    // User is signed out
} catch let error {
    // Handle sign-out error
}
```
#### Error Handling
All methods in the SupabaseAuth class are marked as throws, which means they can throw errors. Proper error handling is essential to provide a smooth user experience in your application.

## ViewModel:
```

import Foundation
import Combine
import Supabase

// Define authentication states
enum AuthState: Hashable {
    case Initial
    case Signin
    case Signout
}

class AuthViewModel: ObservableObject {
    
    // Published properties for SwiftUI views
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var authState: AuthState = AuthState.Initial
    @Published var isLoading = false
    
    // Cancellable set to manage Combine subscriptions
    var cancellable = Set<AnyCancellable>()
    
    // Initialize Supabase authentication
    private var supabaseAuth: SupabaseAuth = SupabaseAuth()
    
    // Check if the user is signed in
    @MainActor
    func isUserSignIn() async {
        do {
            try await supabaseAuth.LoginUser()
            authState = AuthState.Signin
        } catch _ {
            authState = AuthState.Signout
        }
    }
    
    // Sign up a new user
    @MainActor
    func signup(email: String, password: String) async {
        do {
            isLoading = true
            try await supabaseAuth.SignUp(email: email, password: password)
            authState = AuthState.Signin
            isLoading = false
        } catch let error {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    // Sign in a user
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            isLoading = true
            try await supabaseAuth.SignIn(email: email, password: password)
            authState = AuthState.Signin
            isLoading = false
        } catch let error {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    // Validate email using a regular expression
    func validEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isEmailValid = self.email.range(of: emailRegex, options: .regularExpression) != nil
        return isEmailValid
    }
    
    // Validate password using a regular expression
    func validPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*\\.).{8,}$"
        let isPasswordValid = self.password.range(of: passwordRegex, options: .regularExpression) != nil
        return isPasswordValid
    }
    
    // Sign out a user
    @MainActor
    func signoutUser() async {
        do {
            try await supabaseAuth.signOut()
            authState = AuthState.Signout
        } catch let error {
            errorMessage = error.localizedDescription
        }
    }
}
```

## Explanation:
- [x] AuthState Enum: This enum defines three authentication states - Initial, Signin, and Signout. It's used to track the user's authentication state.
- [x] @Published Properties: These properties are marked with @Published, making them observable by SwiftUI views. Changes to these properties will automatically trigger view updates.
- [x] Cancellable Set: It's used to manage Combine subscriptions, preventing memory leaks.
- [x] SupabaseAuth: An instance of SupabaseAuth is used for authentication operations. It's assumed to be a custom class handling authentication.
- [x] isUserSignIn(): Checks if the user is already signed in by attempting to log in silently. Updates authState accordingly.
- [x] signup(): Signs up a new user with the provided email and password. It sets isLoading while the operation is in progress and handles errors.
- [x] signIn(): Signs in an existing user with the provided email and password. Similar to signup(), it also handles errors and loading states.
- [x] validEmail(): Validates the email using a regular expression to ensure it matches the expected format.
- [x] validPassword(): Validates the password using a regular expression to enforce complexity requirements.
- [x] signoutUser(): Signs out the currently authenticated user and updates the authState. Handles errors if any occur.

## Design the User Interface
```
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
```
## Explanation:
1. @EnvironmentObject: This is a property wrapper provided by SwiftUI. It allows you to inject an object (in this case, AuthViewModel and NavigationViewModel) into the environment of a view. This means that the view will have access to these objects without needing to explicitly pass them.

2. Switch: This is a control flow statement. It checks the value of authViewModel.authState and performs different actions based on its value.

- [x] Case .Initial: If the authentication state is Initial, it displays a Text view with the message "Loading". This likely indicates that the app is in the process of determining the user's authentication state.
- [x] Case .Signin: If the authentication state is Signin, it displays the HomeView. Additionally, it injects both authViewModel and navigationViewModel as environment objects into HomeView.
- [x] Case .Signout: If the authentication state is Signout, it displays the LoginView. Like with the HomeView, it injects authViewModel and navigationViewModel as environment objects into LoginView.

3. .task: This modifier is used to perform asynchronous work when the view appears. In this case, it calls the isUserSignIn method of authViewModel using the await keyword.

## Overall: 
ContentView is a SwiftUI view responsible for managing the main content of your app based on the user's authentication state. Depending on whether the user is signed in or not, it displays either a loading message, the home view, or the login view. The environment objects authViewModel and navigationViewModel are provided to the child views (HomeView and LoginView) for them to use.

