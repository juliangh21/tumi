//
//  SignInEmailView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/3/26.
//

import SwiftUI
import Combine
import Foundation
import Firebase
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoURL: String?
    
    init (user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

@MainActor
final class SettingsViewModel: ObservableObject{
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}


@MainActor
final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    func signIn() async -> Bool{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return false
        }
        
            do{
                let returnedUserdata = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("success")
                print(returnedUserdata)
                return true
            }
            catch{
                print("Error: \(error)")
                return false
            }
    
        
        
    }
}
struct SignInEmailView: View {
    @StateObject private var ViewModel = SignInEmailViewModel()
    @State var x: Bool? = nil
    var canmoveon: (Bool) -> Void
    var body: some View {
        
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                textInputField(inputtype: "Email", input: $ViewModel.email)
                textInputField(inputtype: "Password", input: $ViewModel.password)
                Button(action: {Task{
                    let success = await ViewModel.signIn()
                    canmoveon(success)
                }}){
                    CompleteButton(colorOfButton: Color.accentorange, input: "Make Password", widthheight: [130, 30])
                }
          
            }
        }
        
        .navigationTitle("Sign up with email")
        
    }
    
}

//#Preview {
//    SignInEmailView( canmoveon: {x in})
//}


final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
    func createUser(email: String, password: String) async throws{
        let authDataresult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataresult.user)
    }
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)

    }
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
}



