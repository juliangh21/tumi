//
//  AddRecipeSheet.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/19/26.
//

import SwiftUI
import Foundation

enum addrankconfirm{
    case add
    case rank
    case confirm
}
struct AddRecipeSheet: View {
    var RecipeList: [Recipe]
    var recipeAdded: (Recipe) -> Void
    @State var currentPage: addrankconfirm = .add
    var body: some View{
        switch currentPage {
        case .add:
            addSheet(recipeAdded: { recipenew in
                recipeAdded(recipenew)
            })
        case .rank:
            
        case .confirm:
            
        }
    }
}

struct addSheet: View{
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

struct RankSheetView: View {
    var recipeList: [Recipe]
    var newRecipe: Recipe
    @State var currentcomparedRecipe: Recipe
    @State var continueranking = true
    var body: some View {
//        let therecipeList = sortRecipe(list1: recipeList)
//        let forlooplength = Int(log2(Double(therecipeList.count)))
//        var count = 0
        ForEach(nextrecipes(list1: recipeList)) { list in
            
        }
        
        

        
        recipeComparison(oldrecipe: nextrecipes(list1: recipeList)[], newRecipe: newRecipe, betterRecipe: <#T##(Recipe) -> Void#>)
    }
}


func nextrecipes(list1: [Recipe]) -> [Recipe]{
    var list2 = sortRecipe(list1: list1)
    let forlooplength = (list2.count)
    var mid = forlooplength/2
    var goodRecipeList : [Recipe] = []
    var count = Int(log2(Double(list2.count)))
    while (count < forlooplength){
        goodRecipeList.append(list1[mid])
        mid = mid/2
    }
    return goodRecipeList
}

struct recipecomparisonbutton: View {
    var recipecomp1: Recipe
    var recipepreffered: (Recipe?) -> Void
    var body: some View {
        Button(action: {print("Recipe preffered"); recipepreffered(recipecomp1)}) {
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(.brown)
                    .frame(width: 113, height: 30)
                Text(recipecomp1.getName())
                    .bold()
            }
        }
        
    }
}


struct recipeComparison: View {
    var oldrecipe: Recipe
    var newRecipe: Recipe
    var betterRecipe: (Recipe) -> Void
    
    var body: some View {
        HStack{
            Spacer()
            recipecomparisonbutton(recipecomp1: oldrecipe, recipepreffered: { recipepreffered in
                if(recipepreffered == nil){
                }
                else if (recipepreffered != nil){
                    betterRecipe(recipepreffered!)
                }
            })
            Spacer()
            recipecomparisonbutton(recipecomp1: newRecipe, recipepreffered: { recipepreffered in
                if(recipepreffered == nil){
                }
                else if (recipepreffered != nil){
                    betterRecipe(recipepreffered!)
                }
            })
            Spacer()
        }
        
        
    }
}
