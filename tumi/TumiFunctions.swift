//
//  TumiFunctions.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/27/26.
//
import SwiftUI
import Foundation
func sortRecipe(list1:[Recipe], _ SelectedCategory: String?)->[Recipe]{
    let sortedRecipe = list1.sorted{ $0.getRank()<$1.getRank()}
    let sr1 = catrecipeonly(list1: sortedRecipe, SelectedCategory: SelectedCategory)
    return sr1
}

func resortrecipe(list1:[Recipe])->[Recipe] {
    var r1 = sortRecipe(list1: list1, nil)
    NicePrintRecipe(list1: r1)
    for i in r1.indices{
        r1[i].changeRank(newRank: i+1)
        
    }
    NicePrintRecipe(list1: r1)
    return r1
}
func NicePrintRecipe(list1:[Recipe])->(Void){
    for i in list1.indices{
        print(list1[i].getName() + " has a rank of " + String(list1[i].getRank()))
    }
}

func catrecipeonly(list1:[Recipe], SelectedCategory: String?)->[Recipe]{ //this function sorts through a list of recipes that only have the selected category
    var goodRecipes : [Recipe] = []
    if(SelectedCategory==nil || SelectedCategory == ""){//if not selected category: no change
        return list1
    }
    if(SelectedCategory == "Date" || SelectedCategory == "Alphabetically"){
        if(SelectedCategory == "Date"){
            print("date selected....trying to filter")
            let dateSortedRecipe = list1.sorted{$0.getDate() < $1.getDate()}
            print(dateSortedRecipe)
            return dateSortedRecipe
        }
        else{
            let alphasortedrecipe = list1.sorted{$0.getName() < $1.getName()}
            return alphasortedrecipe
        }
    }
    else{
        for recipe in list1 {
            if (recipe.getRank( ) == -1){
                print("NOPE")
                
            }
            else if (recipe.getType().lowercased() == SelectedCategory?.lowercased()){
                goodRecipes.append(recipe)
            }
        }
    }
    
    return goodRecipes
}
func deleteRecipe(list1: [Recipe], recipe: Recipe){
    let index = list1.firstIndex(of: recipe)!
//    return Int(index!)
//    list1[index].changeRank(newRank: -1)
}


func categoryslist(list1:[Recipe])-> [String]{
//    var catlist: [String] = []
//    for i in list1.indices{
//        catlist.append(list1[i].getType())
//    }
//    for i in catlist.indices{
//        if (!(catlist.firstIndex(of: catlist[i])==i)){
//            catlist.remove(at: i)
//        }
//    }
//    catlist.append("Custom Category")
//    return catlist
    return []
}

func ImageToData(image:UIImage?) -> Data?{
    if (image == nil){
        return nil
    }
    else{
        let data = image!.pngData()
    //    let data = image?.jpegData(compressionQuality: 0.9)
        
        return data!
    }
    
    
        
}

func getUniqueCategories(RecipeList: [Recipe]) -> [String]{
    var categorys: [String] = []
    for recipe in RecipeList{
        if(!(categorys.contains(recipe.getType().lowercased()))){ //this sorts through all the diffrenrt categories and finds the unique ones. Then, it adds them to a list.
            categorys.append(recipe.getType().lowercased())
        }
    }
    return categorys
}

func offsetAngle(angle: Angle) -> [CGFloat]{
    let radians = CGFloat(angle.radians)
    let x = 10*cos(radians)
    let y = 10*sin(radians)
    return [x,y]
    
}

func getPrettyErrorCode(error: String) -> String{
    var fullerrorcode = "Error: "
    var onewasswitched = false
    if error.contains("Code=17020"){
        fullerrorcode += " Network error (such as timeout, interrupted connection or unreachable host) has occurred."
        onewasswitched = true
    }
    if error.contains("Code=-1003"){
        fullerrorcode += " A server with the specified hostname could not be found."
        onewasswitched = true
    }
    if(!onewasswitched){
        return error
    }
    return fullerrorcode
}


func recipeSources() -> [String]{
    return ["Website", "Youtube Video", "TikTok", "Magazine", "Book", "Personal"]
    
}
