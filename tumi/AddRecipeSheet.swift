//
//  AddRecipeSheet.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/19/26.
//

import SwiftUI

struct AddRecipeSheet: View {
    @State var recipename  = ""
    @State var recipeCategory = ""
    var recipeAdded: (Recipe) -> Void
    var body: some View {
        VStack{
            Text("Add Recipe")
                .font(.title)
                .padding()
//            Spacer()
            TextField("Recipe name", text: $recipename)
                .padding()
//            Spacer()
            Text("Add Recipe Category")
            TextField("Recipe Category", text: $recipeCategory)
            Button("Add recipe"){
                print("Recipe added")
                let recipenew = Recipe(recipeRank: 2, recipeName: recipename, recipeType: recipeCategory)
                recipeAdded(recipenew)
            }
        }
        
    }
}
