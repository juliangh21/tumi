//
//  RecipeManager.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/4/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine

@MainActor

final class RecipeManager: ObservableObject{
    @Published var recipes: [Recipe] = []
    private var uid: String?
    private var username: String = ""
    private let db = Firestore.firestore()
    
    private var collectionRef: CollectionReference?{
        guard let uid  else {return nil}
        return db.collection("users").document(uid).collection("recipes")
    }
    func loadUser(uid: String, username: String) async{
        self.uid = uid
        self.username = username
        await fetchRecipes()
    }
    func clearUser(){
        uid = nil
        recipes = []
    }
    func fetchRecipes() async{
        guard let ref = collectionRef else{return}
        do{
            let snapshot =  try await ref.getDocuments()
            recipes = try snapshot.documents.compactMap({try $0.data(as: Recipe.self)})
            recipes = resortrecipe(list1: recipes)
        }
        catch{
            print(error)
        }
        
    }
    
    func savePubRecipes( recipe: Recipe) async{
        guard let uid else{return }//if user isn't logged in, quit
        let pub = publicRecipe(id: recipe.id, uid: uid, recipeName: recipe.getName(), recipeType: recipe.getType(), datecreated: recipe.getDate(), authorName: username,recipeNameLower: recipe.getName().lowercased())
        do{
            try db.collection("publicRecipes").document(recipe.id).setData(from:pub) // goes into the database, find the collection called "Public Recipes", then at document recipe.id.sets the recipe
            print("pub recipe saved")
            
        }
        catch{
            print("Save publicrecipeerror:  \(error)")
        }
        
    }
    func deletePrivateRecipe(recipe: Recipe) async{
        guard let uid else{return}
        do{
            try await db.collection("publicRecipes").document(recipe.id).delete()
        }
        catch{
            print("Delete public recipe error: \(error)")
        }
    }
    
    func fetchPublicRecipes(search: String = "" ) async -> [publicRecipe]{
        var query: Query = db.collection("publicRecipes")
            .order(by: "datecreated", descending: true)
            .limit(to: 50)
        if !search.isEmpty{
            let lower = search.lowercased()
            query = db.collection("publicRecipes")
                .whereField("recipeNameLower", isGreaterThanOrEqualTo: lower)
                .whereField("recipeNameLower", isLessThan: lower+"\u{f8ff}")
                .limit(to: 50) //only 50 results are shwoed
        }
        do{
            let snapshot = try await query.getDocuments()
            return try snapshot.documents.compactMap({try $0.data(as: publicRecipe.self)})
        }
        catch{
            print("Searcherror: \(error)")
            return []
        }
    }
    
    func saveRecipes(_ recipe: Recipe) async{
        guard let ref = collectionRef else{return}
        var recipetosave = recipe
        if let imageData = recipe.Image{
            print("save the DANG URL")
            recipetosave.imageURL = await uploadImage(imageData: imageData, recipeId: recipe.id)
        }
        do{
            print("IT failed")
            try ref.document(recipe.id).setData(from: recipetosave)
            
        }
        catch{
            print("image saved error")
            print(error)
        }
    }
    func deleteRecipe(_ recipe: Recipe) async{
        guard let ref = collectionRef else{return}
        do{
            try await ref.document(recipe.id).delete()
            
        }
        catch{
            print(error)
        }
    }
    func uploadImage(imageData: Data, recipeId: String) async -> String?{
        print("trying to upload")
        let ref = Storage.storage().reference()
            .child("users/\(uid ?? "")/recipes/\(recipeId).jpg")
        print(ref)
        print("TRYING")
        do{
            guard let compressed = UIImage(data: imageData)?
                .jpegData(compressionQuality: 0.5) else{return nil}
            _ = try await ref.putDataAsync(compressed)
            let url = try await ref.downloadURL()
            print("WORK IMAGE UPLOAD")
            return url.absoluteString
        }
        catch{
            print("Image upload ERROR :\(error) ")
            return nil
        }
            
            
            
        
    }
    
}
