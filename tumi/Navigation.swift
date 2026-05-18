//
//  Navigation.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/25/26.
//
import SwiftUI
import Combine
enum appRoute: Hashable{
    case home
//    case newRecipe
    case recipe(Recipe)
//    case settings
}

class appRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func goTo(to route1: appRoute){
        path.append(route1) //adds a new route
    }
    func goBack(){
        path.removeLast()
    }
    func goRoot(){
        path = NavigationPath()
    }
}
