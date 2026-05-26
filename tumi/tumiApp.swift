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
    @State var RecipeArray =
    [Recipe(recipeRank: 2, recipeName: "x", recipeType: "1"),
     Recipe(recipeRank: 1, recipeName: "y", recipeType: "B"),  //this is the list of recipes
     Recipe(recipeRank: 3, recipeName: "z", recipeType: "b")]
    var body: some Scene {
//        WindowGroup {
////            ContentView(Recipes: ListOfRecipes)
//            ContentView()
//        }
        WindowGroup{
            NavigationStack(path: $router.path){
                ContentView(RecipeArray: $RecipeArray)
                    .navigationDestination(for: appRoute.self){ route in
                        switch route {
                            case .home:
                                ContentView(RecipeArray: $RecipeArray)
                            case .recipe(let recipe):
                                recipeView(theRecipe: recipe, newRecipe: {
                                    bothrecipes in
                                    let firstindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                                    if(firstindex == nil){
                                        
                                    }else{
                                        RecipeArray[firstindex!] = bothrecipes.getNewRecipe()
                                    }
                                    
                                })
                                    Color.lightbrownbkgrnd
                                        .ignoresSafeArea()
                            }
                            
                        }
                    .environmentObject(router)
                
                    }
                
            }
        
        }
        
}

