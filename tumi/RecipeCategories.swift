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
    }
}




struct listOfcategories: View{
    var Recipes: [Recipe]
    var onTap: (String?) -> Void
    @State var selectedcategory: String? = nil
        var uniqueCategories: [String] {
            var categorys: [String] = []
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
                            if (selectedcategory==category){//if button is double tapped, unpress
                                selectedcategory = nil
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
    }
}
