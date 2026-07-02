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
    var id: String = UUID().uuidString // NOTE: If you add non optional things to the recipe struct, new recipes won't load anymore because they won't work. EVERYTHING OPTIONAL.
    var recipeRank: Int
    var recipeName: String
    var recipeType: String
    var datecreated: Date = Date()
    var Image: Data? = nil
    var imageURL: String? = nil
    var source: String = ""
    var angleRandom = Double.random(in:-25...25)
    var recipeSourceType: String?
    var recipeMeal: String?
    var recipeNotes: String?
    enum CodingKeys: String, CodingKey {
            case id, recipeRank, recipeName, recipeType, datecreated, imageURL, source, angleRandom, recipeSourceType, recipeMeal, recipeNotes
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
    func getDate() -> Date{
        return datecreated
    }
    func getAngleRandom()-> Double{
        return angleRandom
    }
    func getRecipeSourceType() -> String{
        checkIfNil(variable: recipeSourceType, niltext: "Recipe source type")
    }
    func getRecipeMealTime() -> String{
        checkIfNil(variable: recipeMeal, niltext: "Recipe meal")
    }
    func getRecipeNotes() -> String{
//        checkIfNil(variable: recipeNotes, niltext: "Recipe Notes")
        if recipeNotes != nil {
            return recipeNotes!
        }
        else{
            return " "
        }
    }
    func isRecipeMealTimePresent() -> Bool{
        return recipeMeal != nil
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
struct userProfile:Identifiable, Hashable, Codable{
    var id: String = UUID().uuidString
    var username: String
    var emailAddress: String
    var profilePic: Data? = nil
    var imageURL: String? = nil
    var dateCreated: Date = Date()
    enum CodingKeys: String, CodingKey {
            case id, username, emailAddress, imageURL, dateCreated
            // Image is intentionally omitted
        }
    func getUsername() ->String{
        return username
    }
    func getEmailaddress() -> String{
        return emailAddress
    }
    func getDateCreated() -> Date{
        return dateCreated
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
struct publicRecipe: Identifiable, Hashable, Codable{ //this is the recipe struct
//    var id = UUID()
    var id: String
    var uid: String
    var recipeName: String
    var recipeType: String

    var datecreated: Date
//    var Image: Data? = nil
//    var imageURL: String? = nil
    var source: String = ""
    var authorName: String
    var recipeNameLower: String
    enum CodingKeys: String, CodingKey {
            case id, uid, recipeName, recipeType, datecreated, source, authorName, recipeNameLower
            // Image is intentionally omitted
        }

    func getName() -> String{
        return recipeName
    }
    func getType() -> String{
        return recipeType
    }
    func getSourceString() -> String{
        return source
    }
    func getDate() -> Date{
        return datecreated
    }
    func getAuthorUserName() -> String{
        return authorName
    }
    
}


struct filterRecipes: Identifiable, Hashable{
    let id = UUID() // this makes it identifiable
    var recipe: Recipe? = nil
    var isFilteringCats = true
    var catFiltered: String?  = nil
    
    func getRecipeName() -> String?{
        if !isFilteringCats{
            return recipe!.getName()
        }
        return nil
    }
    func getcatFiltered() -> String?{
        if isFilteringCats{
            return catFiltered!
        }
        return nil
    }
    func getisFilteringCats() -> Bool{
        return isFilteringCats
    }
}
