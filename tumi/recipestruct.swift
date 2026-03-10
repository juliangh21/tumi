//
//  recipestruct.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/8/26.
//

import SwiftUI

    
struct Recipe: Identifiable{
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
