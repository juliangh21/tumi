//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

struct RecipeList: View{
    
//    @Binding var Recipes: [Recipe]
    var Recipes: [Recipe]
    var body: some View {
        VStack{
            ForEach(sortRecipe(list1: Recipes)) {card in
                if(card.getRank() == -1){
//                    print("not today")
                }
                else{
                    Ranker(theRecipe:card ,rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType()) //this sorts through a list of recipes and will create a viewable list of recipes
                }
                
            }

        }
    }
}

struct ContentView: View {
    @EnvironmentObject var router: appRouter
    @State var RecipeArray =
        [Recipe(recipeRank: 2, recipeName: "x", recipeType: "1"),
         Recipe(recipeRank: 1, recipeName: "y", recipeType: "B"),  //this is the list of recipes
         Recipe(recipeRank: 3, recipeName: "z", recipeType: "b")]
    @State var CategoryRecipeArray: [Recipe] = []
    @State var selectedCategory: String? = nil
    @State var recipeSheetshowing: Bool = false
    var body: some View{
        VStack{
            listOfcategories(Recipes: RecipeArray, onTap: { selectedcategory in //this is the closure statement. From the listOfcategories struct, it grabs a value, and runs the code
                
                if !(selectedCategory == selectedcategory){
                    selectedCategory = selectedcategory
                }
            })
            ScrollView{ // makes it scroll so there is an infinite amount of recipes
//                RecipeList(Recipes: $RecipeArray)
                RecipeList(Recipes: catrecipeonly(list1: RecipeArray, SelectedCategory: selectedCategory))
                Button("Add recipe"){
                    RecipeArray.append(Recipe(recipeRank: (Int.random(in: 1...10)), recipeName: "r", recipeType: String(Int.random(in: 1...10)))) //this adds a recipe to the list
                    print("Recipe added")
                    
                }
                
            }
            Button("Add Recipe"){
                recipeSheetshowing = true
            }
            .sheet(isPresented: $recipeSheetshowing){
                AddRecipeSheet(RecipeList: RecipeArray, recipeAdded: { recipenew in
                    RecipeArray.append(recipenew)
                    print("New Recipe added")
                    recipeSheetshowing = false
                })
            }
            
        }
        
        
    }
}

func sortRecipe(list1:[Recipe])->[Recipe]{
    let sortedRecipe = list1.sorted{ $0.getRank()<$1.getRank()}
    return sortedRecipe
}

func catrecipeonly(list1:[Recipe], SelectedCategory: String?)->[Recipe]{ //this function sorts through a list of recipes that only have the selected category
    var goodRecipes : [Recipe] = []
    if(SelectedCategory==nil){//if not selected category: no change
        return list1
    }
    for recipe in list1 {
        if (recipe.getRank( ) == -1){
            print("NOPE")
            
        }
        else if (recipe.getType().lowercased() == SelectedCategory?.lowercased()){
            goodRecipes.append(recipe)
        }
    }
    return goodRecipes
}


#Preview {
    @Previewable @StateObject var router = appRouter()
    NavigationStack(path: $router.path){
        ContentView()
            .navigationDestination(for: appRoute.self){ route in
                switch route {
                    case .home:
                        ContentView()
                    case .recipe(let recipe):
                        recipeView(theRecipe: recipe)
                    }
                    
                }
            .environmentObject(router)
            }
        
    }

