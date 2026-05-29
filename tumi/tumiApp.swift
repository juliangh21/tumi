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
    @State var selectedTab = 0
    @State var RecipeAddSheetPresented = false
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
                TabView(selection: $selectedTab) {
                    Tab("Home", systemImage: "house", value: 0) {
                        //                Text("Home")
                        
                        ContentView(RecipeArray: $RecipeArray)
                        //                    .tag(0)
                        //                            .navigationDestination(for: appRoute.self){ route in
                        //                                switch route {
                        //                                case .home:
                        //                                    ContentView(RecipeArray: $RecipeArray)
                        //                                case .recipe(let recipe):
                        ////                                    print("IMMA CRY")
                        //                                    recipeView(recipeList:RecipeArray, theRecipe: recipe, newRecipe: {
                        //                                        
                        //                                        bothrecipes in
                        //                                        print("IMMA CRY")
                        //                                        let firstindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                        //                                        print("WHY")
                        //                                        if(firstindex == nil){
                        //                                            print("NO")
                        //                                            //                            if(bothrecipes.getOldRecipe().getRank()==0){
                        //                                            let oldindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                        //                                            let newindex = bothrecipes.getOldRecipe().getRank() - 1
                        //                                            RecipeArray.insert(bothrecipes.getNewRecipe(), at: bothrecipes.getOldRecipe().getRank())
                        //                                            if(oldindex==nil){
                        //                                                
                        //                                            }
                        //                                            else if(newindex<oldindex!){
                        //                                                RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
                        //                                                RecipeArray[oldindex!+1].changeRank(newRank: -1)
                        //                                            }
                        //                                            else if(oldindex!<newindex){
                        //                                                RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
                        //                                                RecipeArray[oldindex!].changeRank(newRank: -1)
                        //                                            }
                        //                                            RecipeArray = resortrecipe(list1: RecipeArray)
                        //                                            //                            }
                        //                                        }else{
                        //                                            print("I LOVE")
                        //                                            RecipeArray[firstindex!] = bothrecipes.getNewRecipe()
                        //                                            print(bothrecipes)
                        //                                        }
                        //                                        
                        //                                    })
                        ////                                    Color.lightbrownbkgrnd
                        ////                                        .ignoresSafeArea()
                        //                                }
                        
                    }
                    //                            .environmentObject(router)
                    
                    
                    Tab("Add Recipe", systemImage: "plus", value:1) {
                        //                addRecipeButton(RecipeArray: $RecipeArray)
                        EmptyView()
                        
                    }
                    //            Tab("Settings", systemImage: "gear") {
                    //                Text("Profile")
                    //                .tag(2)
                    //            }
                }
                .onChange(of: selectedTab){ oldValue, newValue in
                    if(newValue == 1){
                        RecipeAddSheetPresented = true
                        selectedTab = oldValue
                    }
                }
                .sheet(isPresented: $RecipeAddSheetPresented){
                    AddRecipeSheet(RecipeList: RecipeArray, recipeAdded: { recipenew in
                        RecipeArray.append(recipenew)
                        RecipeArray = resortrecipe(list1: RecipeArray)
                        print("New Recipe added")
                        RecipeAddSheetPresented = false
                    })
                    .presentationDetents([.medium, .large])
                }
                .navigationDestination(for: appRoute.self){ route in
                    switch route {
                    case .home:
                        ContentView(RecipeArray: $RecipeArray)
                    case .recipe(let recipe):
                        //                                    print("IMMA CRY")
                        recipeView(recipeList:RecipeArray, theRecipe: recipe, newRecipe: {
                            
                            bothrecipes in
                            print("IMMA CRY")
                            let firstindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                            print("WHY")
                            if(firstindex == nil){
                                print("NO")
                                //                            if(bothrecipes.getOldRecipe().getRank()==0){
                                let oldindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
                                let newindex = bothrecipes.getOldRecipe().getRank() - 1
                                RecipeArray.insert(bothrecipes.getNewRecipe(), at: bothrecipes.getOldRecipe().getRank())
                                if(oldindex==nil){
                                    
                                }
                                else if(newindex<oldindex!){
                                    RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
                                    RecipeArray[oldindex!+1].changeRank(newRank: -1)
                                }
                                else if(oldindex!<newindex){
                                    RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
                                    RecipeArray[oldindex!].changeRank(newRank: -1)
                                }
                                RecipeArray = resortrecipe(list1: RecipeArray)
                                //                            }
                            }else{
                                print("I LOVE")
                                RecipeArray[firstindex!] = bothrecipes.getNewRecipe()
                                print(bothrecipes)
                            }
                            
                        })
                        //                                    Color.lightbrownbkgrnd
                        //                                        .ignoresSafeArea()
                    }
                    
                }
                .environmentObject(router)
                
            }
            
        }
        
    }
}
