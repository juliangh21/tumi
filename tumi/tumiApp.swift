//
//  tumiApp.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

@main
struct tumiApp: App {
    @StateObject var router =  appRouter()
    var body: some Scene {
//        WindowGroup {
////            ContentView(Recipes: ListOfRecipes)
//            ContentView()
//        }
        WindowGroup{
            NavigationStack(path: $router.path){
                ContentView()
                    .navigationDestination(for: appRoute.self){ route in
                        switch route {
                            case .home:
                                ContentView()
                            case .recipe(let recipe):
                                recipeView(theRecipe: recipe)
                                    Color.lightbrownbkgrnd
                                        .ignoresSafeArea()
                            }
                            
                        }
                    .environmentObject(router)
                
                    }
                
            }
        
        }
        
}

