//
//  GoogleSignInView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/1/26.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseCore

//FirebaseApp.configure()


class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      if FirebaseApp.app() != nil {
          print("✅ Firebase is successfully configured!")
      } else {
          print("❌ Firebase is NOT configured. Call FirebaseApp.configure() first.")
      }

      return true
  }

}



struct SignInView: View {
    @State var browhat = false
    var body: some View {
        VStack{
            NavigationLink{
                //                    brownRectangle(width: 240, height: 45)
                SignInEmailView(canmoveon: {x in})

            }label:{
                ZStack{
                    brownRectangle(width: 240, height: 55)
                    Text("Sign in with Email")
                        .foregroundStyle(Color.brownfont)
                }
                   
                }
                
            }
            .navigationTitle("SIGN UP")
            
            
        
    }
}

//struct SignInView_Preview: PreviewProvider{
//    static var previews: some View{
//        NavigationStack{
//            SignInView()
//        }
//    }
//}

#Preview{
    
    NavigationStack{
        SignInView()
    }
}

