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
    var rank: String
    var recipe_name: String
    var recipe_type: String
    var rectwidth: Double = 340
    var body: some View {
        Button(action: {print("tapped");router.goTo(to: .recipe(theRecipe))}){
//            router.goTo(to: .recipe(theRecipe))
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(.brown)
                    .frame(width: CGFloat(rectwidth),height: 80)
    //            Text("1")
    //                .font(.largeTitle)
    //                .padding(.trailing, CGFloat(rectwidth - (0.20*rectwidth)))
    //                .padding()
    //                .frame(maxWidth:.infinity, alignment: .leading)
                infoView(rank: rank, recipe_name: recipe_name, recipe_type: recipe_type, rect_width: rectwidth, rect_height: 80)
                    .padding(.leading)
            }
        }
        
    
    }
}

struct infoView: View { // this is the view for the data from recipe. NOT THE RECTANGLE variables are taken in as parameters and displatd
    var rank: String
//    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rect_width: Double
    var rect_height: Double
    var body: some View {
        HStack(){
            Text(String(rank)+".")
                .font(.largeTitle)
                .foregroundStyle(.black)
//                .padding(.trailing)
//                .frame(width: 340/5)
            Spacer() //spacer to make sure its in the left quarter
            Text(recipe_name)
                .font(.body)
                .foregroundStyle(.black)
            Spacer()
            Spacer()
            Spacer()
            Text(recipe_type)
                .font(.footnote)
                .foregroundStyle(.black)
            
        }
        
        .frame(width: CGFloat((rect_width*0.85)), height: CGFloat((rect_height*0.8)))
    }
}


struct recipeView: View {
    var theRecipe: Recipe
    var body: some View {
        ScrollView{
            VStack{
                Text(theRecipe.recipeName)
                    .font(.largeTitle)
                Spacer()
                Text("Currently ranked " + theRecipe.getRankwsuffix())
                
            }
        }
    }
}
