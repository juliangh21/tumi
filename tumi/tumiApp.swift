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
    [Recipe(recipeRank: 2, recipeName: "2nd Recipe", recipeType: "2"),
     Recipe(recipeRank: 1, recipeName: "1st Recipe", recipeType: "1"),  //this is the list of recipes
     Recipe(recipeRank: 3, recipeName: "3rd Recipe", recipeType: "3")]
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
                            recipeView(recipeList:RecipeArray, theRecipe: recipe, newRecipe: {
                                    bothrecipes in
                                    let firstindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                                    if(firstindex == nil){
                                        
                                    }else{
                                        RecipeArray[firstindex!] = bothrecipes.getNewRecipe()
                                        RecipeArray = resortrecipe(list1: RecipeArray)
                                        print(bothrecipes.getNewRecipe().getRankwsuffix())
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

