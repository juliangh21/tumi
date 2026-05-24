//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

struct RecipeList: View{
    
    //    @Binding var Recipes: [Recipe]
    @Binding var Recipes: [Recipe]
    var body: some View {
        List{
            ForEach(sortRecipe(list1: $Recipes)) {card in
                if(card.getRank() == -1){
                    //                    print("not today")
                }
                else{
                    Ranker(theRecipe:card ,rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType()) //this sorts through a list of recipes and will create a viewable list of recipes
                        .swipeActions{
                            Button(role:.destructive){
                                print("theverge")
                                $Recipes.remove(at:deleteRecipe(list1: Recipes, recipe: card))
                            }label: {
                                //   Image(systemName: "trash")
                                //                            }
                                SwipeDeleteActions()
                                //                                Text("theverge")
                            }
                        }
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
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                listOfcategories(Recipes: RecipeArray, onTap: { selectedcategory in //this is the closure statement. From the listOfcategories struct, it grabs a value, and runs the code
                    
                    if !(selectedCategory == selectedcategory){
                        selectedCategory = selectedcategory
                    }
                })
//                ScrollView{ // makes it scroll so there is an infinite amount of recipes
    //                RecipeList(Recipes: $RecipeArray)
                    RecipeList(Recipes: catrecipeonly(list1: RecipeArray, SelectedCategory: selectedCategory))
//                    Button("Add recipe"){
//                        RecipeArray.append(Recipe(recipeRank: (Int.random(in: 1...10)), recipeName: "r", recipeType: String(Int.random(in: 1...10)))) //this adds a recipe to the list
//                        print("Recipe added")
//                        
//                    }
                    
//                }
                Button("Add Recipe"){
                    recipeSheetshowing = true
                }
                .sheet(isPresented: $recipeSheetshowing){
                    AddRecipeSheet(RecipeList: RecipeArray, recipeAdded: { recipenew in
                        RecipeArray.append(recipenew)
                        RecipeArray = resortrecipe(list1: RecipeArray)
                        print("New Recipe added")
                        recipeSheetshowing = false
                    })
                }
                
            }

        }
                
        
    }
}

func sortRecipe(list1:[Recipe])->[Recipe]{
    let sortedRecipe = list1.sorted{ $0.getRank()<$1.getRank()}
    return sortedRecipe
}

func resortrecipe(list1:[Recipe])->[Recipe] {
    var r1 = sortRecipe(list1: list1)
    for i in r1.indices{
        r1[i].changeRank(newRank: i+1)
    }
    return r1
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
func deleteRecipe(list1: [Recipe], recipe: Recipe)->Int{
    let index = list1.firstIndex(of: recipe)
    return Int(index!)
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
                            Color.lightbrownbkgrnd
                                .ignoresSafeArea()
                    }
                    
                }
            .environmentObject(router)
            }
        
    }

