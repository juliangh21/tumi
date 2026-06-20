//
//  SearchView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/15/26.
//


import SwiftUI

struct searchRecipeBar: View {
    @StateObject var recipemanager  = RecipeManager()
    @State var searchedtext:String =  ""
    @State var searchedrecipes: [publicRecipe] = []
    @State var recipeOut: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                textInputField(inputtype: "Search all recipes... ", input: $searchedtext,notSearching: false)
                    .padding()
                List(searchedrecipes, id: \.self){recipe in
                    Button(action:{recipeOut(Recipe(recipeRank: -1, recipeName: recipe.getName(), recipeType: recipe.getType()))}){
                        RecipePreview(recipeName: recipe.getName(), recipeCategory: recipe.getType())
                    }
                }
                .scrollContentBackground(.hidden)
                .listRowBackground(Color.lightbrownbkgrnd)
            }
            .onChange(of: searchedtext){old, new in
                Task{
                    searchedrecipes =  await recipemanager.fetchPublicRecipes(search: new)
                }
                
                
                
            }
        }
        
//        SearchBar(
//        
    }
}

struct RecipePreview: View {
    var recipeName: String
    var recipeCategory: String
    var body: some View {
        VStack{
            Text(recipeName)
                .font(.body)
                .foregroundStyle(Color.brownfont)
            Text(recipeCategory)
                .font(.footnote)
                .foregroundStyle(Color.secondaryfont)
        }
        
    }
}
//#Preview {
//    searchRecipeBar()
//}
//Text(recipe_name)
////                    .font(.body)
//    .font(.system(size:20))
//    .foregroundStyle(Color.brownfont)
//    .bold()
//Text(recipe_type)
//    .font(.system(size:12))
//    .foregroundStyle(Color.secondaryfont)
