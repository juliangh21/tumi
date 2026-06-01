//
//  Ranker.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/8/26.
//
import SwiftUI

struct Ranker: View { // view for data from recipe and the rectangle. This is the final card
    @EnvironmentObject var router: appRouter
    var theRecipe: Recipe
    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rectwidth: Double = 340
    var body: some View {
        Button(action: {print("tapped");router.goTo(to: .recipe(theRecipe)) }) {
//            router.goTo(to: .recipe(theRecipe))
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.primarybrown)
                    .frame(width: CGFloat(rectwidth),height: 80)
                infoView(rank: rank, recipe_name: recipe_name, recipe_type: recipe_type, rect_width: rectwidth, rect_height: 80)
                    .padding(.leading)
            }
        }
        
    
    }
}

struct infoView: View { // this is the view for the data from recipe. NOT THE RECTANGLE variables are taken in as parameters and displatd
    var rank: Int
//    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rect_width: Double
    var rect_height: Double
    var body: some View {
        HStack(){
            Text(String(rank)+".")
                .font(.largeTitle)
//                .font(.headline)
                .foregroundStyle(Color.darkbrownimpactfont)
//                .padding(.trailing)
//                .frame(width: 340/5)
            Spacer() //spacer to make sure its in the left quarter
            Text(recipe_name)
                .font(.body)
                .foregroundStyle(Color.brownfont)
            Spacer()
            Spacer()
            Spacer()
            Text(recipe_type)
                .font(.footnote)
                .foregroundStyle(Color.secondaryfont)
            
        }
        .frame(width: CGFloat((rect_width*0.85)), height: CGFloat((rect_height*0.8)))
    }
}


struct ImageView: View {
    var uiImage: UIImage
    var Big: Bool
    var body: some View {
        if(Big){
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .frame(width: 100, height: 250)
        }
        else{
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .frame(width: 50, height: 125)
        }
        
    }
}

struct recipeView: View {
    var recipeList: [Recipe]
    @State var theRecipe: Recipe
    @State var editsheetshowing = false
    @State var ranksheetshowing = false
    var newRecipe: (RecipeViewStruct) -> Void
//    var oldrecipeIndex: (String) -> Void
    var body: some View {
            ZStack{
                Color.lightbrownbkgrnd.ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 1 ){
                        Button(action: {editsheetshowing=true}){
                            ZStack{
                                    RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.accentorange)
                                    .frame(width: CGFloat(80),height: 30)
                                    Text("Edit")
                                    .foregroundStyle(Color.white)
                                }

                        }
                        .frame(maxWidth:.infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .sheet(isPresented: $editsheetshowing ){
                            addSheet(Making: false, recipelist: recipeList, recipeAdded: { recipenew in
                                let oldRecipe = theRecipe
                                theRecipe = recipenew
                                editsheetshowing = false
                                let bothRecipes = RecipeViewStruct(newRecipe: recipenew, oldRecipe: oldRecipe)
                                newRecipe(bothRecipes)
                            })
                            .presentationDetents([.medium, .large])
                        }
                        .presentationDetents([.medium, .large])
                        
                            if(theRecipe.getSourceString() != ""){
                                HStack{
                                    Link(destination: URL(string: theRecipe.getSourceString())!,){
                                        Text(theRecipe.recipeName)
                                        //                            .font(.largeTitle)
                                            .font(.system(size:50))
                                            .foregroundStyle(Color.brownfont)
                                            .lineLimit(3)
                                            .allowsTightening(true)
                                            .minimumScaleFactor(0.75)
                                    }
                                    Image(systemName: "link")
                                        .font(.system(size:40))
                                        .foregroundStyle(Color.brownfont)
                                }
                                .padding([.horizontal], 30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            else{
                                Text(theRecipe.recipeName)
        //                            .font(.largeTitle)
                                    .font(.system(size:50))
                                    .foregroundStyle(Color.brownfont)
                                    .lineLimit(3)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.75)
                                    .padding([.horizontal], 30)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                                
                        
                        
                        if (theRecipe.Image != nil){
                            ImageView(uiImage: theRecipe.getImage(), Big: true)
//                            Image(uiImage: theRecipe.getImage())
//                                .resizable()
//                                .scaledToFill()
//                                .clipShape(RoundedRectangle(cornerRadius: 9))
//                                .frame(width: 100, height: 250)
                        }
                        Text("Made on " + String(theRecipe.datecreated.formatted()))
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                            .foregroundStyle(Color.secondaryfont)

                        HStack(spacing: 5){
                            Text("Currently ranked " + theRecipe.getRankwsuffix()+".")
                                .foregroundStyle(Color.secondaryfont)
                            Button(action: {ranksheetshowing=true}){
                                Text("Change that")
                                    .underline()
                                    .foregroundStyle(Color.secondaryfont)
                            }
                            .sheet(isPresented: $ranksheetshowing){
                                RankSheetView(recipeList: recipeList, newRecipe: theRecipe, rankclosureout: {
                                    finalRank in
//                                    theRecipe.changeRank(newRank: finalRank)
                                    let oldRecipe = theRecipe
                                    theRecipe.changeRank(newRank: finalRank)
                                    print(finalRank)
                                    print(theRecipe.getRankwsuffix())
                                    ranksheetshowing = false
                                    let bothRecipes = RecipeViewStruct(newRecipe: theRecipe, oldRecipe: oldRecipe)
                                    newRecipe(bothRecipes)
                                })
                                .presentationDetents([.medium, .large])
                            }
                            .presentationDetents([.medium, .large])
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
//                .frame(maxWidth: .infinity, maxHeight:.infinity)
                
            }
            
        
    }
}
