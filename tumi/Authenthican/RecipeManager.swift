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
    private let db = Firestore.firestore()
    
    private var collectionRef: CollectionReference?{
        guard let uid  else {return nil}
        return db.collection("users").document(uid).collection("recipes")
    }
    func loadUser(uid: String) async{
        self.uid = uid
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
    func saveRecipes(_ recipe: Recipe) async{
        guard let ref = collectionRef else{return}
        var recipetosave = recipe
        if let imageData = recipe.Image{
            recipetosave.imageURL = await uploadImage(imageData: imageData, recipeId: recipe.id)
        }
        do{
                
            try ref.document(recipe.id).setData(from: recipetosave)
            
        }
        catch{
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
        let ref = Storage.storage().reference()
            .child("users/\(uid ?? "")/recipes/\(recipeId).jpg")
        do{
            guard let compressed = UIImage(data: imageData)?
                .jpegData(compressionQuality: 0.5) else{return nil}
            _ = try await ref.putDataAsync(compressed)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }
        catch{
            print("ERROR :\(error) ")
            return nil
        }
            
            
            
        
    }
    
}
