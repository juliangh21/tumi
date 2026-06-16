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
            .onImageCaptured{
                image, controller in
                controller.closeMCamera()
                theImage(image)
            }
            .startSession()
    }
}
