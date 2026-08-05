//
//  pickerButtonView.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/29/26.
//

import SwiftUI
struct pickerButton: View {
    @State var inputtype: String = "Recipe Category"
    var theinputType: String {
        return inputtype
    }
    @State var custom = false
    @State var pickershowing = false
    @State var catpicked = false
    @Binding var picked: String
    @Binding var SourceType: String
//    @State var CategoryLabel = "Pick Recipe Category"
    var list: [Recipe]
    var isSource : Bool?{
        if(pickerType == "Source"){
            return true
        }
        else if(pickerType == "Meal Type"){
            return false
        }
        else{
            return nil
        }
    }
    var pickerType: String
    var catRecipes: [String]{
        if(isSource != nil && isSource!){
            print("not recipe meal type. Source")
            return recipeSources()
            
        }
        else if(isSource != nil && !isSource!){
            print("REcipe meal type source")
            return recipeMealType()
        }
        else{
            print("bad boy")
            print(isSource)
            var x: [String] = []
                    for recipe in list {
                        if(x.contains(recipe.getType())){
                            
                        }
                        else{
                            x.append(recipe.getType())
                        }
                            
                    }
                    x.append("Custom Category")
                    return x
        }
        
    }
    var body: some View {
        ZStack(alignment: .leading){
            brownRectangle(width: .infinity, height: 45)
//                .padding(.horizontal)
            Button(action:{pickershowing = true}){
                HStack{
                    Text(inputtype)
                        .foregroundStyle(Color.mutedgray)
                    if(catpicked){sfSymbolImage(imageName: "arrow.uturn.backward", imageColor: Color.brown)}
                }
                
            }
            .padding(.horizontal)
            .confirmationDialog("Pick your category", isPresented: $pickershowing, titleVisibility: .hidden){
                ForEach(catRecipes, id: \.self){ recipecat in
                    Button(action: {picked = recipecat;inputtype = recipecat;
                        if picked == "Custom Category"{
                            
                            custom = true
                        }
                        else if(isSource != nil && isSource!){
                            custom = true
                        }
                    }){
                        Text(recipecat)
                        
                    }
                }
//
                
            }
            if(!(custom) /*|| list.count != 0*/){// don't uncomment list.count != 0. THis breaks everything. no clue why.
                Button(action:{pickershowing = true}){
//                    Text("Recipe Category")
//                        .foregroundStyle(Color.mutedgray)
                    
                }
                .padding(.horizontal)
                .confirmationDialog("Pick your category", isPresented: $pickershowing, titleVisibility: .hidden){
                    ForEach(catRecipes, id: \.self){ recipecat in
                        Button(action: {picked = recipecat}){
//                            HStack{
                                Text(recipecat)
//                                Image(systemName: "chevron.up.chevron.down")
//                                    .foregroundStyle(Color.mutedgray)
//                            }
                            
                        }
                    }
                    .onChange(of: picked){ old, new in
//                        inputtype = picked
//                        catpicked = true
                        if(picked == "Custom Category" /*|| picked == inputtype*/){
                            inputtype = picked
                            catpicked = true
                            custom = true
                            picked = ""
                            print("Custom cat")
                        }
                        else if(isSource != nil && isSource! ){
                            custom = true
                            inputtype = "Type your source (of \(picked)) "
                            print("custom source selected")
                            custom = true
                            SourceType = picked
//                            picked = ""
                        }
                        else{
                            print("chat it didn't work(source name obv)")
                        }
//                        if
                    }

                    
                }
                .padding(.horizontal)
                .frame(width: .infinity, height: 45)
                .foregroundStyle(Color.mutedgray)
                
            }
            else if(custom){
                ZStack{
                    textInputField(inputtype: inputtype, input: $picked)
                    HStack{
                        Spacer()
                        Button(action:{ custom=false; pickershowing = true;inputtype=theinputType}){
                            sfSymbolImage(imageName: "arrow.uturn.backward", imageColor: Color.brown)
                        }
                        Spacer()
                            .frame(width:25)
                    }
                    .frame(width: 220,height: 45)
                    

                }
                
            }
        }
//        .onChange(of:picked){old, new in
//            if !new.isEmpty {
//                    inputtype = new
//                }
//        }
        
    }
}
