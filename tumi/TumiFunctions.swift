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
    let sr1 = catrecipeonly(list1: sortedRecipe, SelectedCategory: SelectedCategory, recipe: nil)
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

func catrecipeonly(list1:[Recipe], SelectedCategory: String?, recipe: Recipe?)->[Recipe]{ //this function sorts through a list of recipes that only have the selected category
    var goodRecipes : [Recipe] = []
    if(SelectedCategory==nil || SelectedCategory == "" && recipe == nil){//if not selected category: no change
        return list1
    }
    if(recipe != nil){
       print("only the recipe has been returned")
        return [recipe!]
    }
    else{
        if(SelectedCategory == "Date" || SelectedCategory == "A-Z"){ // checking if sorting date or A-Z
            if(SelectedCategory == "Date"){
                print("date selected....trying to filter")
                let dateSortedRecipe = list1.sorted{$0.getDate() < $1.getDate()} //sorts date
                print(dateSortedRecipe)
                return dateSortedRecipe
            }
            else{
                print("A-Z selected... trying to filter")
                let alphasortedrecipe = list1.sorted{$0.getName() < $1.getName()} // sorts name
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


//func getPrettyErrorCode(error: String) -> String {
//    var fullerrorcode = "Error: "
//    var onewasswitched = false
//    
//    // Original cases provided in your snippet
//    if error.contains("Code=17020") {
//        fullerrorcode += " Network error (such as timeout, interrupted connection or unreachable host) has occurred."
//        onewasswitched = true
//    }
//    if error.contains("Code=-1003") {
//        fullerrorcode += " A server with the specified hostname could not be found."
//        onewasswitched = true
//    }
//    if error.contains("Code=17008") {
//        fullerrorcode += " The email address is badly formatted."
//        onewasswitched = true
//    }
//    if error.contains("Code=17011") {
//        fullerrorcode += " User account was not found."
//        onewasswitched = true
//    }
//
//    // Additional cases from Firebase AuthErrorCode documentation
//    if error.contains("Code=17000") {
//        fullerrorcode += " Invalid custom token."
//        onewasswitched = true
//    }
//    if error.contains("Code=17002") {
//        fullerrorcode += " Custom token mismatch (Service account and API key belong to different projects)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17004") {
//        fullerrorcode += " Invalid credential (IDP token or requestUri is invalid)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17005") {
//        fullerrorcode += " User account is disabled."
//        onewasswitched = true
//    }
//    if error.contains("Code=17006") {
//        fullerrorcode += " Operation not allowed (Identity provider is disabled)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17007") {
//        fullerrorcode += " Email is already in use."
//        onewasswitched = true
//    }
//    if error.contains("Code=17009") {
//        fullerrorcode += " Wrong password."
//        onewasswitched = true
//    }
//    if error.contains("Code=17010") {
//        fullerrorcode += " Too many requests. Please try again later."
//        onewasswitched = true
//    }
//    if error.contains("Code=17012") {
//        fullerrorcode += " Account exists with different credential (linking required)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17014") {
//        fullerrorcode += " This operation requires recent login. Please sign in again."
//        onewasswitched = true
//    }
//    if error.contains("Code=17015") {
//        fullerrorcode += " Provider is already linked to this account."
//        onewasswitched = true
//    }
//    if error.contains("Code=17016") {
//        fullerrorcode += " No such provider linked to this account."
//        onewasswitched = true
//    }
//    if error.contains("Code=17017") {
//        fullerrorcode += " Invalid user token. Please sign in again."
//        onewasswitched = true
//    }
//    if error.contains("Code=17021") {
//        fullerrorcode += " User token expired. Please sign in again."
//        onewasswitched = true
//    }
//    if error.contains("Code=17023") {
//        fullerrorcode += " Invalid API Key."
//        onewasswitched = true
//    }
//    if error.contains("Code=17024") {
//        fullerrorcode += " User mismatch (Reauthentication failed)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17025") {
//        fullerrorcode += " Credential already in use by a different account."
//        onewasswitched = true
//    }
//    if error.contains("Code=17026") {
//        fullerrorcode += " Weak password."
//        onewasswitched = true
//    }
//    if error.contains("Code=17028") {
//        fullerrorcode += " App not authorized to use Firebase Auth with this API Key."
//        onewasswitched = true
//    }
//    if error.contains("Code=17029") {
//        fullerrorcode += " Expired action code."
//        onewasswitched = true
//    }
//    if error.contains("Code=17030") {
//        fullerrorcode += " Invalid action code."
//        onewasswitched = true
//    }
//    if error.contains("Code=17031") {
//        fullerrorcode += " Invalid message payload."
//        onewasswitched = true
//    }
//    if error.contains("Code=17032") {
//        fullerrorcode += " Invalid sender email."
//        onewasswitched = true
//    }
//    if error.contains("Code=17033") {
//        fullerrorcode += " Invalid recipient email."
//        onewasswitched = true
//    }
//    if error.contains("Code=17034") {
//        fullerrorcode += " Missing email address."
//        onewasswitched = true
//    }
//    if error.contains("Code=17036") {
//        fullerrorcode += " Missing iOS Bundle ID."
//        onewasswitched = true
//    }
//    if error.contains("Code=17037") {
//        fullerrorcode += " Missing Android Package Name."
//        onewasswitched = true
//    }
//    if error.contains("Code=17038") {
//        fullerrorcode += " Unauthorized domain."
//        onewasswitched = true
//    }
//    if error.contains("Code=17039") {
//        fullerrorcode += " Invalid continue URI."
//        onewasswitched = true
//    }
//    if error.contains("Code=17040") {
//        fullerrorcode += " Missing continue URI."
//        onewasswitched = true
//    }
//    if error.contains("Code=17041") {
//        fullerrorcode += " Missing phone number."
//        onewasswitched = true
//    }
//    if error.contains("Code=17042") {
//        fullerrorcode += " Invalid phone number."
//        onewasswitched = true
//    }
//    if error.contains("Code=17043") {
//        fullerrorcode += " Missing verification code."
//        onewasswitched = true
//    }
//    if error.contains("Code=17044") {
//        fullerrorcode += " Invalid verification code."
//        onewasswitched = true
//    }
//    if error.contains("Code=17045") {
//        fullerrorcode += " Missing verification ID."
//        onewasswitched = true
//    }
//    if error.contains("Code=17046") {
//        fullerrorcode += " Invalid verification ID."
//        onewasswitched = true
//    }
//    if error.contains("Code=17047") {
//        fullerrorcode += " Missing app credential (APNS token)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17048") {
//        fullerrorcode += " Invalid app credential (APNS token)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17051") {
//        fullerrorcode += " Session expired (SMS code expired)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17052") {
//        fullerrorcode += " SMS quota exceeded."
//        onewasswitched = true
//    }
//    if error.contains("Code=17053") {
//        fullerrorcode += " Missing app token (APNs device token)."
//        onewasswitched = true
//    }
//    if error.contains("Code=17054") {
//        fullerrorcode += " Notification not forwarded to Firebase Auth."
//        onewasswitched = true
//    }
//    if error.contains("Code=17055") {
//        fullerrorcode += " App not verified."
//        onewasswitched = true
//    }
//    if error.contains("Code=17056") {
//        fullerrorcode += " reCAPTCHA check failed."
//        onewasswitched = true
//    }
//    if error.contains("Code=17057") {
//        fullerrorcode += " Web context already presented."
//        onewasswitched = true
//    }
//
//    if !onewasswitched {
//        return error
//    }
//    return fullerrorcode
//}

///

func recipeSources() -> [String]{
    return ["Website", "Youtube Video", "TikTok", "Magazine", "Book", "Personal"]
    
}
func recipeMealType() -> [String]{
    return  ["Breakfast", "Lunch", "Dinner", "Brunch", "Appetizer", "Snack" ]
}


func checkIfNil(variable: String?, niltext: String) -> String{
    if variable != nil {
        return variable!
    }
    else{
        return "No \(niltext) found."
    }
}
