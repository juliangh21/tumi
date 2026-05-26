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
}
struct AddRecipeSheet: View {
    var RecipeList: [Recipe]
    var recipeAdded: (Recipe) -> Void
    @State var newRecipe = Recipe(recipeRank: 0, recipeName: "", recipeType: " ")
    @State var currentPage: addrankconfirm = .add
    @State var finalrank = -1
    var body: some View{
        switch currentPage {
        case .add:
            
            addSheet(EditOrAdd: "Add",recipeAdded: { recipenew in
                newRecipe = recipenew
                currentPage = .rank
            })
        case .rank:
            RankSheetView(recipeList: RecipeList, newRecipe: newRecipe, rankclosureout: {
                finalRank in
                finalrank = finalRank
                newRecipe.recipeRank = finalrank
                recipeAdded(newRecipe)
            })
        
            
        }
    }
}
struct addSheet: View{
    var EditOrAdd: String
    @State var recipename  = ""
    @State var recipeCategory = ""
    var recipeAdded: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                Text(EditOrAdd + " Recipe")
                    .font(.title)
                    .foregroundStyle(Color.darkbrownimpactfont)
    //                .padding()
    //            Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 9)
                        .fill(Color.primarybrown)
                        .frame(width: 340, height: 80)
                    TextField("Recipe Name", text: $recipename)
    //                    .padding()
    //                    .padding(.vertical, 140)
                        .padding(.horizontal,50)
                }
                Text("Add Recipe Category")
    //            TextField("Recipe Category", text: $recipeCategory)
    //                .padding()
                ZStack{
                    RoundedRectangle(cornerRadius: 9)
                        .fill(Color.primarybrown)
                        .frame(width: 340, height: 80)
                    TextField("Recipe Category", text: $recipeCategory)
    //                    .padding()
    //                    .padding(.vertical, 140)
                        .padding(.horizontal,50)
                }
                Button("Add recipe"){
                    print("Recipe added")
                    let recipenew = Recipe(recipeRank: 2, recipeName: recipename, recipeType: recipeCategory)
                    recipeAdded(recipenew)
                }
            }
        }
        
        
    }
}

struct RankSheetView: View {
    var recipeList: [Recipe]
    var newRecipe: Recipe
    var rankclosureout: (Int) ->Void
    //    var sendout : (Bool) -> Void
    @State var currentindex: Int = 0
    @State var low = 0
    @State var mid = 0
    @State var high = 0
    @State var sortedRecipe: [Recipe] = []
    @State var isDone = false
    @State var finalRank = 0
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                if isDone{
                    Button(action: {rankclosureout(finalRank)}){
                        Text("Confirm this new recipe")
                    }
                    
                }
                else if !(sortedRecipe.count == 0){
                    recipeComparison(oldrecipe: sortedRecipe[mid], newRecipe: newRecipe, betterRecipe: {
                        recipepreffered in
                        nextrecipes(preffered: recipepreffered)
                    } )
                }
                else{
                    ProgressView()
                }
            }
            .onAppear{
                sortedRecipe = sortRecipe(list1: recipeList)
                low = 0
                mid = (high+low)/2
                high = sortedRecipe.count - 1
            }
        }
        
    }
    func nextrecipes(preffered: Recipe){
        if preffered.id==newRecipe.id{
            low = mid + 1
        } else{
            high = mid - 1
        }
        if low>high{
            finalRank = low
            isDone = true
        }
        else{
            mid = (low+high)/2
        }
        
    }
    
}
struct recipecomparisonbutton: View {
    var recipecomp1: Recipe
    var recipepreffered: (Recipe?) -> Void
    var body: some View {
        Button(action: {print("Recipe preffered"); recipepreffered(recipecomp1)}) {
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.primarybrown)
                    .frame(width: 113, height: 90)
                Text(recipecomp1.getName())
                    .foregroundStyle(Color.secondaryfont)
            }
        }
        
    }
}
struct recipeComparison: View {
    var oldrecipe: Recipe
    var newRecipe: Recipe
    var betterRecipe: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                Text("Click on the better recipe")
                    .font(.title)
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
                
        
        
    }
}
