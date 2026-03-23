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
                Ranker(rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType())
            }
        }
    }
}

struct ContentView: View {
    @State var RecipeArray =
        [Recipe(recipeRank: "2", recipeName: "x", recipeType: "s"),
         Recipe(recipeRank: "1", recipeName: "y", recipeType: "a"),
         Recipe(recipeRank: "3", recipeName: "z", recipeType: "b")]
    var body: some View{
        ScrollView{
            RecipeList(Recipes: $RecipeArray)
            Button("Add recipe"){
                RecipeArray.append(Recipe(recipeRank: "4", recipeName: "r", recipeType: "1"))
                print("added")
                print(RecipeArray)
            }
        }
        
//        RecipeList(Recipes: RecipeArray)
    }
}

func sortRecipe(list1:[Recipe])->[Recipe]{
    let sortedRecipe = list1.sorted{$0.getRank()<$1.getRank()}
    return sortedRecipe
}

#Preview {
    ContentView()
}
