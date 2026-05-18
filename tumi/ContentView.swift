//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

struct RecipeList: View{
    
    @Binding var Recipes: [Recipe]
    var body: some View {
        VStack{
            ForEach(sortRecipe(list1: Recipes)) {card in
                Ranker(theRecipe:card ,rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType()) //this sorts through a list of recipes and will create a viewable list of recipes
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
    var body: some View{
        VStack{
            listOfcategories(Recipes: RecipeArray)
            ScrollView{ // makes it scroll so there is an infinite amount of recipes
                RecipeList(Recipes: $RecipeArray)
                Button("Add recipe"){
                    RecipeArray.append(Recipe(recipeRank: (Int.random(in: 1...10)), recipeName: "r", recipeType: String(Int.random(in: 1...10)))) //this adds a recipe to the list
                    print("Recipe added")
                    
                }
            }
        }
        
        
    }
}

func sortRecipe(list1:[Recipe])->[Recipe]{
    let sortedRecipe = list1.sorted{ $0.getRank()<$1.getRank()}
    return sortedRecipe
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

