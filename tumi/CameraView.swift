//
//  CameraView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/7/26.
//

import MijickCamera
import SwiftUI

struct theCameraView: View {
    var theImage: (UIImage?) -> Void
    var body: some View {
        MCamera()
            .setErrorScreen(CustomCameraErrorScreen.init)
            .setCameraOutputType(.photo)
            .onImageCaptured{
                image, controller in
                controller.closeMCamera()
                theImage(image)
            }
            .startSession()
    }
}

struct CustomCameraErrorScreen: MCameraErrorScreen{
    let error: MCameraError
    let closeMCameraAction: () -> ()
    
    var body: some View{
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            opensettings(error: error)
        }
        
        
    }
}


struct opensettings: View {
    var error: MCameraError
    @Environment(\.openURL)  var openSettings
    var body: some View {
            ZStack(alignment: .center){
                brownRectangle(width: .infinity, height: CGFloat(45))
                    .padding(.horizontal)
                Button(action:{
                    if let url = URL(string: UIApplication.openSettingsURLString){
                        openSettings(url)
                    }
                }){
                    Text("Your microphone and/or camera need to be enabled. Open Settings App to change")
                        .foregroundStyle(Color.mutedgray)
                }
            }
    }
}
