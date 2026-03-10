//
//  ContentView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var totalinfo =
            [Recipe(recipeRank: "1", recipeName: "Strawberry Salad", recipeType: "Salad"),
             Recipe(recipeRank: "2", recipeName: "Burrata with Tomatoes", recipeType: "Appetizer"),
             Recipe(recipeRank: "3", recipeName: "Crepes", recipeType: "Breakfast")]
        VStack{
            ForEach(totalinfo) {card in
                Ranker(rank: card.getRank(), recipe_name: card.getName(), recipe_type: card.getType())
            }
        }
    }
}



#Preview {
    ContentView()

}
