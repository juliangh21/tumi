//
//  TabView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/28/26.
//
import SwiftUI
struct tabs: View{
    var body: some View{
        TabView {
            Tab("Home", systemImage: "house") {
//                Text("Home")
            }
            Tab("Add Recipe", systemImage: "plus") {
//                Text("Search")
            }
            Tab("Settings", systemImage: "gear") {
//                Text("Profile")
            }
        }
    }
}


//#Preview {
//    tabs()
//}
