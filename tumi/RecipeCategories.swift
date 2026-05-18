//
//  RecipeCategories.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/18/26.
//

import SwiftUI

struct categoryframe: View{
    var color: Color
//    var selectornot: Bool
    var body: some View{
//        Button(action: print("Cat tapped")){
//            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: CGFloat(80),height: 30)
//                Text(caterogy)
//                    .tint(.white)
//                
//            }
//        }
//    
//        
    }
}




struct listOfcategories: View{
    var Recipes: [Recipe]
    @State var selectedcategory: String? = nil
        var uniqueCategories: [String] {
            var categorys: [String] = []
            for recipe in Recipes{
                if(!(categorys.contains(recipe.getType().lowercased()))){
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
                            if (selectedcategory==category){
                                selectedcategory = nil
                            }
                            else{
                                selectedcategory=category
                            }
                        }){
                        ZStack{
                            if(selectedcategory == (category)){
                                categoryframe(color: .orange)
                            }
                            else{
                                categoryframe(color: .gray)
                            }
                            Text(category)
                                .tint(.white)
                    
                                }
                            }
                }
            }
            .padding(.leading, 35)
            .padding(.trailing, 35)
        }
    }
}
