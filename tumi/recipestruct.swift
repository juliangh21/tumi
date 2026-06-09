//
//  recipestruct.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/8/26.
//

import SwiftUI
import Firebase
import FirebaseFirestore
    
struct Recipe: Identifiable, Hashable, Codable{ //this is the recipe struct
//    var id = UUID()
    var id: String = UUID().uuidString
    var recipeRank: Int
    var recipeName: String
    var recipeType: String
    var datecreated: Date = Date()
    var Image: Data? = nil
    var imageURL: String? = nil
    var source: String = ""
    enum CodingKeys: String, CodingKey {
            case id, recipeRank, recipeName, recipeType, datecreated, imageURL, source
            // Image is intentionally omitted
        }

    func getRank() -> Int{
        return recipeRank
    }
    mutating func changeRank(newRank: Int) -> (){ // mutating is when you change smth about the struct. For example, change rank
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
    func hasImage() -> Bool{
        return Image != nil
    }
    func getRankwsuffix() -> String{
        if(recipeRank == 1){
            return (String(recipeRank) + "st")
        }
        else if (recipeRank == 2){
            return (String(recipeRank) + "nd")
        }
        else if(recipeRank == 3){
            return (String(recipeRank) + "rd")
        }
        else{
            return (String(recipeRank) + "th")
        }
//        for i in 1...4{
//            if(i =  )){
//            //            return (recipeRank + "st")
//            //        }
//        }
    }
    func getImage() -> UIImage{
//        return UIImage(data: Image?? Image(systemName: “photo”).frame(width: 0.001, height: 0.001))
        if let Image = Image{
            return UIImage(data: Image)!
        }
        return UIImage(systemName: "camera")!
    }
    func getSourceString() -> String{
        return source
    }
}

struct RecipeViewStruct: Identifiable, Hashable{ //this is the recipe struct
    let id = UUID()
    var newRecipe: Recipe
    var oldRecipe: Recipe
//    var isEditing: Bool
//    var rank: Int
//    func getNewRank() -> Int{
//        return rank
//    }
//    func getOldRank() -> Int{
//        return oldRecipe.getRank()
//    }
    func getOldRecipe() -> Recipe {
        return oldRecipe
    }
    func getNewRecipe() -> Recipe {
        return newRecipe
    }
}

struct errorBoolStruct: Identifiable, Hashable{
    let id = UUID()
    var error: String
    var boolean: Bool
    
    func getError() -> String{
        return error
    }
    func getBoolean() -> Bool{
        return boolean
    }
}

//@/*ViewBuilder*/ //this returns the best recipe among two recipes
//func betterrank(r1:Recipe, r2: Recipe)-> some View{
//    if(r1.getRank()>r2.getRank()){
//        Ranker(rank: r1.getRank(), recipe_name: r1.getName(), recipe_type: r1.getType())
//    }
//    else{
//        Ranker(rank: r2.getRank(), recipe_name: r2.getName(), recipe_type: r2.getType())
//    }
//}
