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
final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        
        Task{
            do{
                let returnedUserdata = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("success")
                print(returnedUserdata)
            }
            catch{
                print("Error: \(error)")
            }
        }
        
    }
}
struct SignInEmailView: View {
    @StateObject private var ViewModel = SignInEmailViewModel()
    var body: some View {
        VStack{
            textInputField(inputtype: "Email", input: $ViewModel.email)
            textInputField(inputtype: "Password", input: $ViewModel.password)
            Button(action: {ViewModel.signIn()}){
                CompleteButton(colorOfButton: Color.accentorange, input: "Make Password", widthheight: [130, 30])
            }
            
            
            
            
        }
        .navigationTitle("Sign up with email")
        
    }
    
}

final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
    func createUser(email: String, password: String) async throws{
        let authDataresult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataresult.user)
    }
}



