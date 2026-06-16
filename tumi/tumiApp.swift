//
//  tumiApp.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI
import FirebaseAuth



@main
struct tumiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var router =  appRouter()
    @StateObject var recipemanager  = RecipeManager()
    @State var selectedTab = 0
    @State var RecipeAddSheetPresented = false
    @State var SignInSheetPresented: Bool = true
    @State var username = ""
//    @State var RecipeArray =
//    [Recipe(recipeRank: 2, recipeName: "2nd Recipe", recipeType: "2"),
//     Recipe(recipeRank: 1, recipeName: "1st Recipe", recipeType: "1"),  //this is the list of recipes
//     Recipe(recipeRank: 3, recipeName: "3rd Recipe", recipeType: "3")]
    var catRecipes: [String]{
        var x: [String] = []
        for recipe in recipemanager.recipes {
            if(!(x.contains(recipe.getType()))){
                
            }
            else{
                x.append(recipe.getType())
            }
                
        }
        return x
    }
    var body: some Scene {
        //        WindowGroup {
        ////            ContentView(Recipes: ListOfRecipes)
        //            ContentView()
        //        }
        
        WindowGroup{
            NavigationStack(path: $router.path){
                TabView(selection: $selectedTab) {
                    Tab("Home", systemImage: "house", value: 0) {
                        
                        ContentView(RecipeArray:recipemanager.recipes )
                    }
                    
                    
                    Tab("Add Recipe", systemImage: "plus", value:1) {
                        EmptyView()
                        
                    }
                    Tab("Profile Out", systemImage: "person.circle", value: 2){
                        ProfileView(username: username , signedout: {x in
                            if x{
                                SignInSheetPresented = true
                            }
                            })
                    }
                    Tab("Camera", systemImage: "Camera", value: 3){
                        theCameraView(theImage: {x in})
                        
                    }
                    

                }

                .onChange(of: selectedTab){ oldValue, newValue in
                    if(newValue == 1){
                        RecipeAddSheetPresented = true
                        selectedTab = /*oldValue*/ 0
                    }
                }
                .sheet(isPresented: $RecipeAddSheetPresented){
                    AddRecipeSheet(RecipeList: recipemanager.recipes, recipeAdded: { recipenew in
                        /*RecipeArray*/recipemanager.recipes.append(recipenew)
                        recipemanager.recipes = resortrecipe(list1: recipemanager.recipes)
                        // Task { await $recipemanager.saveRecipe(recipe: recipenew) }
                        Task {
                            await recipemanager.saveRecipes(recipenew)
                            await recipemanager.savePubRecipes(recipe: recipenew)
                        }
                        
                        print("New Recipe added")
                        RecipeAddSheetPresented = false
                    })
                    .presentationDetents([.medium, .large])
                }
                .navigationDestination(for: appRoute.self){ route in
                    switch route {
                    case .home:
                        ContentView(RecipeArray: recipemanager.recipes /*$RecipeArray*/)
                    case .recipe(let recipe):
                        //                                    print("IMMA CRY")
                        recipeView(recipeList:recipemanager.recipes, theRecipe: recipe, newRecipe: {
                            
                            bothrecipes in
                            print("IMMA CRY")
                            let firstindex = recipemanager.recipes/*RecipeArray*/.firstIndex(of: bothrecipes.getOldRecipe())
                            print("WHY")
                            if(firstindex == nil){
                                print("NO")
                                //                            if(bothrecipes.getOldRecipe().getRank()==0){
                                let oldindex = recipemanager.recipes/*RecipeArray*/.firstIndex(of: bothrecipes.getOldRecipe())
                                let newindex = bothrecipes.getOldRecipe().getRank() - 1
                                /*RecipeArray*/recipemanager.recipes.insert(bothrecipes.getNewRecipe(), at: bothrecipes.getOldRecipe().getRank())
                                Task { await recipemanager.saveRecipes(bothrecipes.getNewRecipe()) }
                                if(oldindex==nil){
                                    
                                }
                                else if(newindex<oldindex!){
                                    /*RecipeArray*/recipemanager.recipes.insert(bothrecipes.getNewRecipe(), at: newindex)
                                    /*RecipeArray*/recipemanager.recipes[oldindex!+1].changeRank(newRank: -1)
                                    Task { await recipemanager.deleteRecipe( bothrecipes.getOldRecipe()) }
                                }
                                else if(oldindex!<newindex){
                                    /*RecipeArray*/recipemanager.recipes.insert(bothrecipes.getNewRecipe(), at: newindex)
                                    /*RecipeArray*/recipemanager.recipes[oldindex!].changeRank(newRank: -1)
                                    Task { await recipemanager.deleteRecipe( bothrecipes.getOldRecipe()) }
                                }
                                recipemanager.recipes = resortrecipe(list1: recipemanager.recipes)
                                //                            }
                            }else{
                                print("I LOVE")
                                recipemanager.recipes[firstindex!] = bothrecipes.getNewRecipe()
                                Task { await recipemanager.deleteRecipe( bothrecipes.getOldRecipe()) }
                                print(bothrecipes)
                            }
                            
                        })
                        //                                    Color.lightbrownbkgrnd
                        //                                        .ignoresSafeArea()
                    }
                    
                }
                .environmentObject(router)
                .environmentObject(recipemanager)
                
            }// end of nav stack
            
            .onAppear{
                if let user = Auth.auth().currentUser {
                            Task { await recipemanager.loadUser(uid: user.uid, username: username) }
                    SignInSheetPresented = false
                        }
            
//                let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
//                self.SignInSheetPresented = authuser == nil
            }
            .fullScreenCover(isPresented: $SignInSheetPresented){
                VStack{
                    SignInEmailView(canmoveon: {
                        x in SignInSheetPresented = !x
                        if let user = Auth.auth().currentUser {
                            Task { await recipemanager.loadUser(uid: user.uid, username: username) }
                                }
                        
                    }, email:{ email in username = email
                        
                    })
                    
                }
                
            }
            
        }
        
    }
}
