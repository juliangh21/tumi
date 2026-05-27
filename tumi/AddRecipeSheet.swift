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
            
            addSheet(Making:true, recipeAdded: { recipenew in
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
    var Making: Bool
    @State var recipename  = ""
    @State var recipeCategory = ""
    var recipeAdded: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                Button(action: {let recipenew = Recipe(recipeRank: 2, recipeName: recipename, recipeType: recipeCategory)
                    recipeAdded(recipenew)}){
                ZStack{
                        RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentorange)
                        .frame(width: CGFloat(80),height: 30)
                    if(Making){
                        Text("Rank!")
                            .foregroundStyle(Color.white)
                    }
                    else{
                        Text("Done!")
                            .foregroundStyle(Color.white)
                    }
                        
                }

                }
                .frame(maxWidth:.infinity, alignment: .trailing)
                .padding(.horizontal)
                if(Making){
                    Text("Add your Recipe.")
                        .font(.system(size:50))
                        .foregroundStyle(Color.brownfont)
                        .lineLimit(3)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.75)
                        .padding([.horizontal], 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                else{
                    Text("Edit your Recipe.")
                        .font(.system(size:50))
                        .foregroundStyle(Color.brownfont)
                        .lineLimit(3)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.75)
                        .padding([.horizontal], 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                addButton(inputtype: "Name", input: $recipename)
                addButton(inputtype: "Category", input: $recipeCategory)
            }
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        
//        .ignoresSafeArea(edges: .top)
        
        
    }
}
struct addButton: View {
    var inputtype: String
    @Binding var input: String
    var body: some View {
        HStack{
            Text(inputtype + ":")
                .foregroundStyle(Color.secondaryfont)
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.primarybrown)
                    .frame(width: 240, height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .strokeBorder(Color.brownfont, lineWidth: 1.3)
                    )
                TextField("Recipe " + inputtype, text: $input)
                    .padding(.horizontal)
                    .frame(width: 240, height: 45)
            }
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
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
                    .lineLimit(3)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.75)
                    .frame(width: 103, height: 80)
                    .padding(.horizontal)
                    .padding(.horizontal)
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


//#Preview{
//    addSheet(recipeAdded: { recipenew in
//        print(recipenew)
//    })
//}
