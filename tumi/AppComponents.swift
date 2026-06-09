//
//  CompleteButton.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 6/6/26.
//

import SwiftUI
import PhotosUI
import Foundation


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
                            .foregroundStyle(Color.mutedgray)
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
    var isPassword: Bool = false
    var isNewpassword: Bool = true
    var isloggin: Bool = false
    var widthheigh=[240,45]
    var body: some View {
        ZStack{
            brownRectangle(width: CGFloat(widthheigh[0]), height: CGFloat(widthheigh[1]))
            ZStack{
                Group{
                    if(isloggin){
                        TextField(/*"Recipe " +*/ inputtype, text: $input)
                            .textContentType(.emailAddress)
                            .textContentType(.username)
                    }
                    else if isPassword{
                        SecureField(inputtype, text: $input)
                            .textContentType(isNewpassword  ? .newPassword : .password)
    
                        
                    }
                    else{
                        TextField(/*"Recipe " +*/ inputtype, text: $input)
                    }
                }
                .padding(.horizontal)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .frame(width: max(100,CGFloat(widthheigh[0])), height: max(20,CGFloat(widthheigh[1])))
                
                
                HStack{
                    Spacer()
                    PasteButton(pasted: {
                        newval in input = newval
                    })
                }
                .frame(width: max(90,CGFloat(widthheigh[0])-10),height: max(10,CGFloat(widthheigh[1])-10))
                
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
    @State var custom = false
    @Binding var picked: String
//    @State var CategoryLabel = "Pick Recipe Category"
    var list: [Recipe]
    
    var catRecipes: [String]{
        var x: [String] = []
        for recipe in list {
            if(!(x.contains(recipe.getType()))){
                
            }
            else{
                x.append(recipe.getType())
            }
                
        }
        x.append("Custom Category")
        return x
    }
    var body: some View {
        ZStack{
            brownRectangle(width: 240, height: 45)
            
            if(!(custom) || list.count != 0){
                LabeledContent(inputtype){
                    Picker("Category", selection: $picked){
                        ForEach(catRecipes, id: \.self) { recipe in //the id:\.self makes it indentifaible
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
                .foregroundStyle(Color.mutedgray)
                
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
