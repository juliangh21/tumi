//
//  ModifyRecipeView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/10/26.
//

import SwiftUI

struct overarchingButtonView: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.accentorange)
                .frame(width: 40, height: 40)
            Image(systemName: "ellipsis")
                .resizable()
                .foregroundStyle(Color.lightbrownbkgrnd)
                .scaledToFit()
                .frame(width: 25, height : 25)
        }
        
        
    }
}




#Preview{
    overarchingButtonView()
}
