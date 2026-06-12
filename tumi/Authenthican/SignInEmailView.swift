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
    func signIn() async -> errorBoolStruct{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return (errorBoolStruct(error: "No email or password found", boolean: false))
        }
        
            do{
                let returnedUserdata = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("success")
                print(returnedUserdata)
                return (errorBoolStruct(error: "Success!", boolean: true))
            }
            catch{
                do{
                    let signin = try await AuthenticationManager.shared.signIn(email: email, password: password)
                    print("signed in")
                    return errorBoolStruct(error: "Sucess!", boolean: true)
                }
                catch{
                    print("Error: \(error)")
                    return (errorBoolStruct(error: "Error: \(error)", boolean: false))
                }
                print("Error: \(error)")
                return (errorBoolStruct(error: "Error: \(error)", boolean: false))
                
                //  jgh@tumi.com , tumitumitumi
            }
    
        
        
    }
}
struct SignInEmailView: View {
    @StateObject private var ViewModel = SignInEmailViewModel()
    @State var x: Bool? = nil
    @State var error: String = ""
    var errorText: Bool{
        if(error != "" && error != "Success!"){
            return true
        }
        return false
    }
    var canmoveon: (Bool) -> Void
    var email: (String) -> Void
    var body: some View {
        GeometryReader{ screen in
            let screenwidth = screen.size.width
            ZStack(alignment: .top){
                Color.lightbrownbkgrnd
                    .ignoresSafeArea()
                VStack(spacing: 20){
                
                    BigTextView(input: "You'll need to sign in or sign up.")
                        .padding([.horizontal], -20)
//                        .padding(.vertical)
                    Group{
                        textInputField(inputtype: "Email", input: $ViewModel.email, isloggin: true, widthheigh: [Int(screenwidth)-20, 45])
                        textInputField(inputtype: "Password", input: $ViewModel.password, isPassword: true, widthheigh: [Int(screenwidth)-20, 45])
                    }
                        .shadow(color: Color.brownfont .opacity(0.25), radius: 5, x: 1, y: 1)
                    HStack{
                        if(errorText){
                            Text(getPrettyErrorCode(error: error))
                                .padding()
                        }
                        else{
                            EmptyView()
                        }
                        Button(action: {Task{
                            let success = await ViewModel.signIn()
                            error = success.error
                            email(getUserName())
                            canmoveon(success.getBoolean())
                        }}){
                            CompleteButton(colorOfButton: Color.accentorange, input: "Login!", widthheight: [130, 30])
                        }
                        .shadow(color: Color.brownfont .opacity(0.25), radius: 5, x: 1, y: 1)
                        
                    }
//                    .onChange(of: error){ oldval, newval in
//                        if(newval != "Success!"){
//                            
//                        }
//                    }
                    
              
                }
                .navigationTitle("Sign up with Email")
            }
            
            .navigationTitle("Sign up with email")
        }
        
    }
    func getUserName() -> String{
        return ViewModel.email
    }
    
}

//#Preview {
//    SignInEmailView( canmoveon: {x in})
//}


final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
    func signIn(email: String, password: String) async throws{
        let authDataresult = try await Auth.auth().signIn(withEmail: email, password: password)
        
    }
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



func signOut() throws{
    try Auth.auth().signOut()
}
