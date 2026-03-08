//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Ranker(rank:1, recipe_name: "Strawberry Salad", recipe_type: "Appetizer")
            Ranker(rank:2, recipe_name: "Burrata with Tomatoes", recipe_type: "Appetizer")
            Ranker(rank:3, recipe_name: "Burrata with Tomatoes", recipe_type: "Appetizer")
        }
    }
}
struct Ranker: View {
    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rectwidth: Double = 340
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 9)
                .fill(.brown)
                .frame(width: CGFloat(rectwidth),height: 80)
//            Text("1")
//                .font(.largeTitle)
//                .padding(.trailing, CGFloat(rectwidth - (0.20*rectwidth)))
//                .padding()
//                .frame(maxWidth:.infinity, alignment: .leading)
            infoView(rank: rank, recipe_name: recipe_name, recipe_type: recipe_type)
                .padding(.leading)
        }
    
    }
}

struct infoView: View {
    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rect_width: Double = 340
    var rect_height: Double = 80
    var body: some View {
        HStack(){
            Text(String(rank)+".")
                .font(.largeTitle)
                .padding(.trailing)
//                .frame(width: 340/5)
            Spacer()
            Text(recipe_name)
                .font(.body)
            Spacer()
            Spacer()
            Spacer()
            Text(recipe_type)
                .font(.footnote)
            
        }
        .frame(width: CGFloat((rect_width*0.85)), height: CGFloat((rect_height*0.8)))
    }
}


#Preview {
    ContentView()
}
