//
//  recipestruct.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/8/26.
//

import SwiftUI

    
struct Recipe: Identifiable{ //this is the recipe struct
    let id = UUID()
    var recipeRank: String
    var recipeName: String
    var recipeType: String
    func getRank() -> String{
        return recipeRank
    }
    mutating func changeRank(newRank: String) -> (){
        recipeRank=newRank
    }
    func getName() -> String{
        return recipeName
    }
    mutating func changeName(newName: String) -> (){
        recipeName=newName
    }
    func getType() -> String{
        return recipeType
    }
    mutating func changeType(newType: String) -> (){
        recipeType=newType
    }
}

@ViewBuilder //this returns the best recipe among two recipes
func betterrank(r1:Recipe, r2: Recipe)-> some View{
    if(r1.getRank()>r2.getRank()){
        Ranker(rank: r1.getRank(), recipe_name: r1.getName(), recipe_type: r1.getType())
    }
    else{
        Ranker(rank: r2.getRank(), recipe_name: r2.getName(), recipe_type: r2.getType())
    }
}
