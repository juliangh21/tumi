//
//  RecipeCategories.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/18/26.
//

import SwiftUI
import FirebaseAuth
struct categoryframe: View{
    var color: Color
//    var selectornot: Bool
    var body: some View{
//        Button(action: print("Cat tapped")){
//            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: CGFloat(80),height: 30)
    }
}




struct listOfcategories: View{
    var Recipes: [Recipe]
    var catList: [String]
    var onTap: (String?) -> Void //this is the category that is selected, and the category that is going to be filted
    @State var selectedcategory: String? = nil
    @State var searchRecipeShowing: Bool = false
    var uniqueCategories: [String] {
        var categorys: [String] = []
        categorys.append("Search Recipe")
        categorys.append("Date")
        categorys.append("A-Z")
        for recipe in Recipes{
            if(!(categorys.contains(recipe.getType().lowercased()))){ //this sorts through all the diffrenrt categories and finds the unique ones. Then, it adds them to a list.
                categorys.append(recipe.getType().lowercased())
            }
        }
        return categorys
    }
    var body: some View{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(uniqueCategories, id: \.self){category in
                        Button(action: {
                            print("Cat tapped")
                            if(category == "Search Recipe" && searchRecipeShowing){ // ie, if search recipe is selcted and search recipe showing
                                searchRecipeShowing = false
                                print("search not showing")
                                selectedcategory = nil
                            }
                            else if(category == "Search Recipe" && !searchRecipeShowing){
                                print("search showing")
                                searchRecipeShowing = true
                                selectedcategory = nil

                            }
                            else if (selectedcategory==category){//if button is double tapped, unpress
                                selectedcategory = nil
//                                searc/hRecipeShowing = false
                            }
                            else{
                                selectedcategory=category
                            }
                            onTap(selectedcategory)
                        }){
                        ZStack{
                            if(selectedcategory == (category)){
                                categoryframe(color: Color.accentorange)
                            }
                            else{
                                categoryframe(color: Color.primarybrown)
                            }
                            Text(category)
                                .tint(Color.secondaryfont)
                                .lineLimit(3)
                                .allowsTightening(true)
                                .minimumScaleFactor(0.75)
//                                .padding([.horizontal], 30)
                                .frame(width: 70, height: 25)
                    
                                }
                            }
                            
                        
                }
            }
            
            .padding(.leading, 35)
            .padding(.trailing, 35)
        }
            .sheet(isPresented: $searchRecipeShowing, onDismiss: {selectedcategory=nil; searchRecipeShowing = false}){
                searchRecipesView(recipeList: Recipes, recipeOut: {recipe in  })
            }
    }
}

struct searchRecipesView: View {
    var recipeList: [Recipe]
    @State var searchResults: [Recipe] = []
    @State var searchQuery: String = ""
    var isSearching: Bool{
        searchQuery != ""
    }
    var recipeOut: (Recipe) -> Void
    var body: some View {
        NavigationStack{
            List{
                if(isSearching){
                    ForEach(searchResults){ recipe in
                        Button(action:{recipeOut(recipe)}){
                            Text(recipe.getName())
                        }
                        
                    }
                }
                else{
                    ForEach(recipeList){ recipe in
                        Button(action:{recipeOut(recipe)}){
                            Text(recipe.getName())
                        }
                        
                        
                    }
                }
                
            }
            .navigationTitle("Recipes")
        }
        .searchable(text: $searchQuery, prompt: "Recipe Name")
        .textInputAutocapitalization(.never)
        .onChange(of: searchQuery){
            self.fetchSearchResults(for: searchQuery)
        }
        .overlay(){
            if isSearching&&searchResults.isEmpty{
                ContentUnavailableView(
                    "Recipe not found",
                    systemImage: "magnifyingglass",
                    description: Text("No results for **\(searchQuery)**")
                )
            }
        }
    }
    private func fetchSearchResults(for query: String){
        searchResults = recipeList.filter{ recipe in
            recipe.getName()
                .lowercased()
                .contains(searchQuery) // later maybe add something to the app so people can search recipe names, categorys, etc
                
        }
    }
}

struct allRecipeComponents: View {
    var Recipes: [Recipe]
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
