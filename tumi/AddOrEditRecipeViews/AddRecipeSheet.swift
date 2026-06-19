//
//  AddRecipeSheet.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/19/26.
//

import SwiftUI
import PhotosUI
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

            addSheet(isCreating:true, recipelist: RecipeList, recipeAdded: { recipenew in
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
    var theRecipe:Recipe = Recipe(recipeRank: -1, recipeName: "", recipeType: "")
    var isCreating: Bool
    @State var catcolor = Color.brownfont
    @State var namecolor = Color.brownfont
    @State var canMoveOn1 = false
    
    
    var canMoveOn: Bool{
        !recipename.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !recipeCategory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (selecetedImage != nil)

    }
    var catmoveon: Bool{
        !recipeCategory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || recipeCategory == "Recipe Category"/* && canMoveOn1 && !(recipename == "")*/ /*&&*/ /*(selecetedImage != nil)*/
    }
    var namemoveon: Bool{
        !recipename.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var imagemoveon: Bool{
        selecetedImage != nil
    }
    var colorOfButton: Color{
        if (canMoveOn){
            print("CHANGE")
            return Color.accentorange
        }
        else if (isCreating){
            print("DON'T")
            return Color.mutedgray
        }
        else{
            return Color.accentorange
        }
    }
    var helpuserform: String{
        switch (namemoveon, catmoveon, imagemoveon){
        case(true, true, false): return "Recipe image needed"
        case (true, false, true): return "Recipe category needed"
        case (false, true, true) : return "Recipe name needed"
        case(true, false, false): return "Recipe category and image needed"
        case(false, false, true): return "Recipe name and category needed"
        case(false, true, false): return "Recipe name and image needed"
        case(false, false, false):return "Recipe name, category, and image needed"
        default: return ""
        }
    }
    var recipelist: [Recipe]
    @State var recipename  = ""
    @State var recipeCategory = ""
    @State var selecetedImage: UIImage?
    @State var recipeSource = ""
    @State var isSearchPresented = false
    var recipeAdded: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
//            ScrollView{

                VStack{
                    Button(action: {let recipenew = Recipe(recipeRank: 2, recipeName: recipename, recipeType: recipeCategory, Image: ImageToData(image: selecetedImage! /*?? UIImage(systemName: "gear")*/))
                        recipeAdded(recipenew);canMoveOn1.toggle()}){
                            
                            HStack{
                                Text(helpuserform)
                                    .foregroundStyle(Color.secondaryfont)
                                    .multilineTextAlignment(.trailing)
                                //
                                CompleteButton(colorOfButton: colorOfButton, input: isCreating ? "Rank!": "Done!")
                                    .disabled(!canMoveOn)
                                    .onChange(of: canMoveOn) {oldvalue, newvalue in
                                        print("changed")
                                    }
                                
                            }
                        }
                        .frame(maxWidth:.infinity, alignment: .trailing)
                        .padding(.horizontal)
                    if(isCreating){
                        BigTextView(input: "Add your Recipe.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action:{isSearchPresented.toggle()}){
                            CompleteButton(colorOfButton: Color.darkbrownimpactfont, input: "Search all Recipes...", widthheight: [300,45])
                        }
                    }
                    else{
                        BigTextView(input: "Edit your Recipe.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    addButton(inputtype: "Name", /*input: $recipename,*/ color: namemoveon ? Color.brownfont:Color.red, content: {textInputField(inputtype: isCreating ? "Recipe Name": theRecipe.getName() , input: $recipename)})
                    //                addButton(inputtype: "Category", /*input: $recipename,*/ color: namemoveon ? Color.brownfont:Color.red, content: {textInputField(inputtype: isCreating ? "Recipe Name": theRecipe.getType() , input: $recipeCategory)})
                    addButton(inputtype: "Category", /*input: $recipeCategory,*/ color: catmoveon ? Color.brownfont:Color.red, content: {pickerButton(inputtype: isCreating ? "Recipe Category": theRecipe.getType(), picked: $recipeCategory, list: recipelist)})
                    addButton(inputtype: "Image", /*input: $selecetedImage,*/ color: Color.brownfont, content: {photoPickerView(selecetedImage: $selecetedImage)})
                    Text(" - - - - - Optional - - - - - ")
                        .foregroundStyle(Color.mutedgray)
                        .padding(.vertical)
                    addButton(inputtype: "Source", color: Color.brown, content: {textInputField(inputtype: isCreating ? "Recipe Source": theRecipe.getSourceString(), input: $recipeSource)})
                }
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .sheet(isPresented: $isSearchPresented){
                    searchRecipeBar(recipeOut: {recipe in
                        recipename = recipe.getName()
                        recipeCategory = recipe.getType()
                        isSearchPresented.toggle()
                })
                .presentationDetents([.medium, .large])
                
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
                if(recipeList.count==0){
                    Button(action: {rankclosureout(1)}){
                        Text("Confirm this new recipe")
                    }
                }
                else{
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
            }
            .onAppear{
                sortedRecipe = sortRecipe(list1: recipeList, nil)
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
                Text("Click on the worse recipe")
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


//#Preview{
//    addSheet(recipeAdded: { recipenew in
//        print(recipenew)
//    })
//}
