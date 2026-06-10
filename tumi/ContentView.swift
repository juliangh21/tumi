//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
struct RecipeList: View{
    
    //    @Binding var Recipes: [Recipe]
    /*@Binding*/ var Recipes: [Recipe]
    var category: String
    
    var body: some View {
        var sortedrecipe = resortrecipe(list1: catrecipeonly(list1: Recipes, SelectedCategory: category))
        VStack{
            ForEach(sortRecipe(list1: sortedrecipe)) {card in
                if(card.getRank() == -1){
                    //                    print("not today")
                }
                else{
                    Ranker(theRecipe:card ,rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType())
//                        ./*shadow(color: Color.brownfont .opacity(0.25), radius: 5, x: 1, y: 1)*/
                        .analyticsScreen(name: "WORK HOLY CRAP")//this sorts through a list of recipes and will create a viewable list of recipes

                }
                
            }
            
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var router: appRouter
//    @State var RecipeArray =
//        [Recipe(recipeRank: 2, recipeName: "x", recipeType: "1"),
//         Recipe(recipeRank: 1, recipeName: "y", recipeType: "B"),  //this is the list of recipes
//         Recipe(recipeRank: 3, recipeName: "z", recipeType: "b")]
    /*@Binding */var RecipeArray : [Recipe]
    @State var CategoryRecipeArray: [Recipe] = []
    @State var selectedCategory: String? = nil
    @State var recipeSheetshowing: Bool = false
    var catRecipes: [String]{
        var x: [String] = []
        for recipe in RecipeArray {
            if(!(x.contains(recipe.getType()))){
                
            }
            else{
                x.append(recipe.getType())
            }
                
        }
        return x
    }
    var body: some View{
        
        ZStack{
            
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            
//            VStack{
//                listOfcategories(/*Recipes: RecipeArray*/ Recipes: RecipeArray, catList: catRecipes  , onTap: { selectedcategory in //this is the closure statement. From the listOfcategories struct, it grabs a value, and runs the code
//                    
//                    if !(selectedCategory == selectedcategory){
//                        selectedCategory = selectedcategory
//                    }
//                })
                ScrollView{ // makes it scroll so there is an infinite amount of recipes
                    VStack{
                        listOfcategories(/*Recipes: RecipeArray*/ Recipes: RecipeArray, catList: catRecipes  , onTap: { selectedcategory in //this is the closure statement. From the listOfcategories struct, it grabs a value, and runs the code
                            
                            if !(selectedCategory == selectedcategory){
                                selectedCategory = selectedcategory
                            }
                        })
                        RecipeList(Recipes: RecipeArray, category: selectedCategory ?? "")
                    }
                    

                }
                .scrollClipDisabled()
                

//                }
                
            
            
        }
        
        
    }
}

struct addRecipeButton: View {
    @State var recipeSheetshowing: Bool = false
    @Binding var RecipeArray: [Recipe]
//    var recipeAdded: (Recipe) -> Void
    var body: some View {
        Button("Add Recipe"){
            recipeSheetshowing = true
        }
//        .glassEffect()
//        tint(Color.accentorange)
        .sheet(isPresented: $recipeSheetshowing){
            AddRecipeSheet(RecipeList: RecipeArray, recipeAdded: { recipenew in
                RecipeArray.append(recipenew)
                RecipeArray = resortrecipe(list1: RecipeArray)
                print("New Recipe added")
                recipeSheetshowing = false
            })
            .presentationDetents([.medium, .large])
            
        }
    }
}


//#Preview {
//    @Previewable @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @Previewable @StateObject var router = appRouter()
//    @Previewable @State var selectedTab = 0
//    @Previewable @State var RecipeAddSheetPresented = false
//    @Previewable @State var RecipeArray =
//    [Recipe(recipeRank: 2, recipeName: "x", recipeType: "1", source: "theverge.com"),
//     Recipe(recipeRank: 1, recipeName: "y", recipeType: "B"),  //this is the list of recipes
//     Recipe(recipeRank: 3, recipeName: "z", recipeType: "b")]
//    NavigationStack(path: $router.path){
//        TabView(selection: $selectedTab) {
//            Tab("Home", systemImage: "house", value: 0) {
//                //                Text("Home")
//                
//                ContentView(RecipeArray: $RecipeArray)
//   
//                
//            }
//            
//            Tab("Add Recipe", systemImage: "plus", value:1) {
//                //                addRecipeButton(RecipeArray: $RecipeArray)
//                EmptyView()
//                
//            }
//            //            Tab("Settings", systemImage: "gear") {
//            //                Text("Profile")
//            //                .tag(2)
//            //            }
//        }
//        .onChange(of: selectedTab){ oldValue, newValue in
//            if(newValue == 1){
//                RecipeAddSheetPresented = true
//                selectedTab = oldValue
//            }
//        }
//        .sheet(isPresented: $RecipeAddSheetPresented){
//            AddRecipeSheet(RecipeList: RecipeArray, recipeAdded: { recipenew in
//                RecipeArray.append(recipenew)
//                RecipeArray = resortrecipe(list1: RecipeArray)
//                print("New Recipe added")
//                RecipeAddSheetPresented = false
//            })
//            .presentationDetents([.medium, .large])
//        }
//        .navigationDestination(for: appRoute.self){ route in
//            switch route {
//            case .home:
//                ContentView(RecipeArray: $RecipeArray)
//            case .recipe(let recipe):
//                recipeView(recipeList:RecipeArray, theRecipe: recipe, newRecipe: {
//                    bothrecipes in
//                    let firstindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
//                    print("WHY")
//                    if(firstindex == nil){
//                        print("NO")
//                        //                            if(bothrecipes.getOldRecipe().getRank()==0){
//                        let oldindex = RecipeArray.firstIndex(of: bothrecipes.getOldRecipe())
//                        let newindex = bothrecipes.getOldRecipe().getRank() - 1
//                        RecipeArray.insert(bothrecipes.getNewRecipe(), at: bothrecipes.getOldRecipe().getRank())
//                        if(oldindex==nil){
//                            
//                        }
//                        else if(newindex<oldindex!){
//                            RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
//                            RecipeArray[oldindex!+1].changeRank(newRank: -1)
//                        }
//                        else if(oldindex!<newindex){
//                            RecipeArray.insert(bothrecipes.getNewRecipe(), at: newindex)
//                            RecipeArray[oldindex!].changeRank(newRank: -1)
//                        }
//                        RecipeArray = resortrecipe(list1: RecipeArray)
//                        //                            }
//                    }else{
//                        print("I LOVE")
//                        RecipeArray[firstindex!] = bothrecipes.getNewRecipe()
//                        print(bothrecipes)
//                    }
//                    
//                })
////                Color.lightbrownbkgrnd
////                    .ignoresSafeArea()
//            }
//            
//        }.environmentObject(router)
//        
//    }
//    
//}
