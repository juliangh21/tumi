//
//  ProfileView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/11/26.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ProfileView: View {
    var username: String?
    var signedout: (Bool) -> Void
    var body: some View {
        VStack{
            if username==nil{
                Text("No profile")
            }
            else{
                Text(username!)
            }
            Button(action: {Task{ try Auth.auth().signOut()}}/*, role: .cancel*/){
                Text("Sign out")
            }
        }
    }
}
