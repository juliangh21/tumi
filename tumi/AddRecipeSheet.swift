//
//  AddRecipeSheet.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/19/26.
//

import SwiftUI
import PhotosUI
import Foundation

enum addrankconfirm{
    case add
    case rank
}
struct AddRecipeSheet: View {
    var RecipeList: [Recipe]
    var recipeAdded: (Recipe) -> Void
    @State var newRecipe = Recipe(recipeRank: 0, recipeName: "", recipeType: " ")
    @State var currentPage: addrankconfirm = .add
    @State var finalrank = -1
    var body: some View{
        switch currentPage {
        case .add:

            addSheet(isCreating:true, recipelist: RecipeList, recipeAdded: { recipenew in
                newRecipe = recipenew
                currentPage = .rank
            })
        case .rank:
            RankSheetView(recipeList: RecipeList, newRecipe: newRecipe, rankclosureout: {
                finalRank in
                finalrank = finalRank
                newRecipe.recipeRank = finalrank
                recipeAdded(newRecipe)
            })
        
            
        }
    }
}
struct addSheet: View{
    var theRecipe:Recipe = Recipe(recipeRank: -1, recipeName: "", recipeType: "")
    var isCreating: Bool
    @State var catcolor = Color.brownfont
    @State var namecolor = Color.brownfont
    @State var canMoveOn1 = false
    
    var canMoveOn: Bool{
        !recipename.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !recipeCategory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (selecetedImage != nil)

    }
    var catmoveon: Bool{
        !recipeCategory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty/* && canMoveOn1 && !(recipename == "")*/ /*&&*/ /*(selecetedImage != nil)*/
    }
    var namemoveon: Bool{
        !recipename.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var imagemoveon: Bool{
        selecetedImage != nil
    }
    var colorOfButton: Color{
        if (canMoveOn){
            print("CHANGE")
            return Color.accentorange
        }
        else if (isCreating){
            print("DON'T")
            return Color.gray
        }
        else{
            return Color.accentorange
        }
    }
    var helpuserform: String{
        switch (namemoveon, catmoveon, imagemoveon){
        case(true, true, false): return "Recipe image needed"
        case (true, false, true): return "Recipe category needed"
        case (false, true, true) : return "Recipe name needed"
        case(true, false, false): return "Recipe name and image needed"
        case(false, false, true): return "Recipe name and category needed"
        case(false, true, false): return "Recipe category and image needed"
        case(false, false, false):return "Recipe name, category, and image needed"
        default: return ""
        }
    }
    var recipelist: [Recipe]
    @State var recipename  = ""
    @State var recipeCategory = ""
    @State var selecetedImage: UIImage?
    @State var recipeSource = ""
    var recipeAdded: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                Button(action: {let recipenew = Recipe(recipeRank: 2, recipeName: recipename, recipeType: recipeCategory, Image: ImageToData(image: selecetedImage! /*?? UIImage(systemName: "gear")*/))
                    recipeAdded(recipenew);canMoveOn1.toggle()}){
                        
                        HStack{
                            Text(helpuserform)
                                .foregroundStyle(Color.secondaryfont)
                                .multilineTextAlignment(.trailing)
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 8)
//                                    .fill(colorOfButton)
//                                //                        /*.glassEffec*/t(/*.tint(Color.accentorange)*/)
//                                
//                                    .frame(width: CGFloat(80),height: 30)
//                                if(isCreating){
//                                    Text("Rank!")
//                                        .foregroundStyle(Color.white)
//                                }
//                                else{
//                                    Text("Done!")
//                                        .foregroundStyle(Color.white)
//                                }
//                            }
                            CompleteButton(colorOfButton: colorOfButton, input: isCreating ? "Rank!": "Done!")
                            .disabled(!canMoveOn)
                            .onChange(of: canMoveOn) {oldvalue, newvalue in
                                print("changed")
                        }
                        
                    }
                    }
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .padding(.horizontal)
                if(isCreating){
                    BigTextView(input: "Add your Recipe.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                else{
                    BigTextView(input: "Edit your Recipe.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                addButton(inputtype: "Name", /*input: $recipename,*/ color: namemoveon ? Color.brownfont:Color.red, content: {textInputField(inputtype: isCreating ? "Recipe Name": theRecipe.getName() , input: $recipename)})
                addButton(inputtype: "Category", /*input: $recipeCategory,*/ color: catmoveon ? Color.brownfont:Color.red, content: {pickerButton(inputtype: isCreating ? "Recipe Category": theRecipe.getType(), picked: $recipeCategory, list: recipelist)})
                addButton(inputtype: "Image", /*input: $selecetedImage,*/ color: Color.brownfont, content: {photoPickerView(selecetedImage: $selecetedImage)})
                addButton(inputtype: "Source", color: Color.brown, content: {textInputField(inputtype: isCreating ? "Recipe Source": theRecipe.getSourceString(), input: $recipeSource)})
            }
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
struct CompleteButton: View {
    var colorOfButton: Color
    var input: String
    var widthheight =  [80,30]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(colorOfButton)
                .frame(width: CGFloat(widthheight[0]),height: CGFloat(widthheight[1]))
            Text(input)
                .foregroundStyle(Color.white)
        }
        
    }
}
struct PasteButton: View {
    @State var text = ""
    var pasted: (String) -> Void
    @State var isPressed = false
    var body: some View {
        ZStack{
//            Capsule()
//                .fill(Color.gray)
//                .frame(width: isPressed ? 70:0, height: isPressed ? 30: 0)
//                .offset(y:isPressed ? -50:0)
            
            
            Button(action: pasteFromClipboard){
                Image(systemName: "document.on.clipboard.fill")
                    .foregroundStyle(Color.accentorange)
            }
        }
//        Button(action: pasteFromClipboard){
//            Image(systemName: "document.on.clipboard.fill")
//                .foregroundStyle(Color.accentorange)
//        }
        .onChange(of: text ){ oldval, newval in
            pasted(newval)
        }
    }
        
    func pasteFromClipboard(){
        isPressed.toggle()
        if let string = UIPasteboard.general.string{
            text = string
        }
    }
}

struct BigTextView: View {
    var input: String
    var body: some View {
        Text(input)
            .font(.system(size:50))
            .foregroundStyle(Color.brownfont)
            .lineLimit(3)
            .allowsTightening(true)
            .minimumScaleFactor(0.75)
            .padding([.horizontal], 30)
//            .frame(maxWidth: .infinity, alignment: .leading)
    }
}



struct addButton<Content: View>: View {
    var inputtype: String
//    @Binding var input: String
    var color: Color
    @ViewBuilder let content: () -> Content
    var body: some View {
        HStack{
            Text(inputtype + ":")
                .foregroundStyle(Color.secondaryfont)
            
            ZStack{
//                brownRectangle(width: 240, height: 45)
                content()
            }
            
        }
        .padding(.horizontal)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct photoPickerView: View {
    @State var selectedItem : PhotosPickerItem? // holds the selected image
    @Binding var selecetedImage: UIImage?
    @State var showtext = false// holds the photo
    @State var widthheight = [240,45]
    @State var buffer = 0
    var body: some View {
        ZStack{
            brownRectangle(width: CGFloat(widthheight[0]+buffer), height: CGFloat(widthheight[1]+buffer))
            if let newimage = selecetedImage{
                ImageView(uiImage: newimage, Big:false, widthheight: {
                    newval in
                    widthheight = /*[Int(newimage.size.width), Int(newimage.size.width)]*/ newval
                    
                })
            }
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                    if(!(showtext)){
                        Text("Select your photo")
                            .foregroundStyle(Color.gray)
                    }
                    else{
                        EmptyView()
                    }
                }
                .onChange(of: selectedItem){oldvalue, newvalue in
                    buffer = 12
                    showtext = true
            if let newvalue = newvalue{
                        Task{
                            if let data = try? await newvalue.loadTransferable(type: Data.self), let image = UIImage(data: data){
                                selecetedImage = image
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }

struct textInputField: View {
    var inputtype: String
    @Binding var input: String
    var body: some View {
        ZStack{
            brownRectangle(width: 240, height: 45)
            ZStack{
                TextField(/*"Recipe " +*/ inputtype, text: $input)
                    .padding(.horizontal)
                    .frame(width: 240, height: 45)
                HStack{
                    Spacer()
                    PasteButton(pasted: {
                        newval in input = newval
                    })
                }
                .frame(width: 220,height: 45)
                
            }
            
            
        }
    }
}


struct brownRectangle: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 9)
            .fill(Color.primarybrown)
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .strokeBorder(Color.brownfont, lineWidth: 1.3)
            )
    }
}


struct pickerButton: View {
    @State var inputtype: String = "Pick Recipe Category"
    @Binding var picked: String
//    @State var CategoryLabel = "Pick Recipe Category"
    var list: [Recipe]
    @State var custom = false
    var body: some View {
        ZStack{
            brownRectangle(width: 240, height: 45)
            
            if(!(custom)){
                LabeledContent(inputtype){
                    Picker("Category", selection: $picked){
                        ForEach(categoryslist(list1: list), id: \.self) { recipe in //the id:\.self makes it indentifaible
                            Text(recipe)
                        }
                        
                    }
                    .tint(Color.primarybrown)
                    .colorMultiply(Color.primarybrown)
                    .onChange(of: picked){
                        inputtype = picked
                        if(picked == "Custom Category" /*|| picked == inputtype*/){
                            custom = true
                            picked = ""
                        }
                    }
                }
                .padding(.horizontal)
                .frame(width: 250, height: 45)
                .foregroundStyle(Color.gray)
                
            }
            else if(custom){
                ZStack{
                    textInputField(inputtype: inputtype, input: $picked)
                    HStack{
                        Spacer()
                        Button(action:{ custom=false}){
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundStyle(Color.brown)
                        }
                    }
                    .frame(width: 220,height: 45)
                    

                }
                
            }
        }
        
    }
}
struct RankSheetView: View {
    var recipeList: [Recipe]
    var newRecipe: Recipe
    var rankclosureout: (Int) ->Void
    //    var sendout : (Bool) -> Void
    @State var currentindex: Int = 0
    @State var low = 0
    @State var mid = 0
    @State var high = 0
    @State var sortedRecipe: [Recipe] = []
    @State var isDone = false
    @State var finalRank = 0
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                if isDone{
                    Button(action: {rankclosureout(finalRank)}){
                        Text("Confirm this new recipe")
                    }
                    
                }
                else if !(sortedRecipe.count == 0){
                    recipeComparison(oldrecipe: sortedRecipe[mid], newRecipe: newRecipe, betterRecipe: {
                        recipepreffered in
                        nextrecipes(preffered: recipepreffered)
                    } )
                }
                else{
                    ProgressView()
                }
            }
            .onAppear{
                sortedRecipe = sortRecipe(list1: recipeList)
                low = 0
                mid = (high+low)/2
                high = sortedRecipe.count - 1
            }
        }
        
    }
    func nextrecipes(preffered: Recipe){
        if preffered.id==newRecipe.id{
            low = mid + 1
        } else{
            high = mid - 1
        }
        if low>high{
            finalRank = low
            isDone = true
        }
        else{
            mid = (low+high)/2
        }
        
    }
    
}
struct recipecomparisonbutton: View {
    var recipecomp1: Recipe
    var recipepreffered: (Recipe?) -> Void
    var body: some View {
        Button(action: {print("Recipe preffered"); recipepreffered(recipecomp1)}) {
            ZStack{
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.primarybrown)
                    .frame(width: 113, height: 90)
                Text(recipecomp1.getName())
                    .foregroundStyle(Color.secondaryfont)
                    .lineLimit(3)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.75)
                    .frame(width: 103, height: 80)
                    .padding(.horizontal)
                    .padding(.horizontal)
            }
        }
        
    }
}
struct recipeComparison: View {
    var oldrecipe: Recipe
    var newRecipe: Recipe
    var betterRecipe: (Recipe) -> Void
    var body: some View {
        ZStack{
            Color.lightbrownbkgrnd
                .ignoresSafeArea()
            VStack{
                Text("Click on the worse recipe")
                    .font(.title)
                HStack{
                    Spacer()
                    recipecomparisonbutton(recipecomp1: oldrecipe, recipepreffered: { recipepreffered in
                        if(recipepreffered == nil){
                        }
                        else if (recipepreffered != nil){
                            betterRecipe(recipepreffered!)
                        }
                    })
                    Spacer()
                    recipecomparisonbutton(recipecomp1: newRecipe, recipepreffered: { recipepreffered in
                        if(recipepreffered == nil){
                        }
                        else if (recipepreffered != nil){
                            betterRecipe(recipepreffered!)
                        }
                    })
                    Spacer()
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


//#Preview{
//    addSheet(recipeAdded: { recipenew in
//        print(recipenew)
//    })
//}
