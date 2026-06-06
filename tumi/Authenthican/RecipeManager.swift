//
//  RecipeManager.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/4/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
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
        do{
            try ref.document(recipe.id).setData(from: recipe)
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
    
}
