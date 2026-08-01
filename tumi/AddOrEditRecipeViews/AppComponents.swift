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
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
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
               
            Spacer()
                .frame(width:10)
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
    @Binding var selecetedImage: UIImage?// holds the photo
    @State var showtext = false
    @State var widthheight = [240,45]
    @State var buffer = 0
    @State var rectChange = false
    @State var libraryorImageCD = false
    @State var liborphoto: Bool? = nil//if true, lib, if false, photo
    @State var showcamera = false
    var body: some View {
        ZStack(alignment: /*rectChange ? .center :*/ .leading){
            brownRectangle(width: rectChange ? CGFloat(widthheight[0] + 10): .infinity/*CGFloat(widthheight[0]+buffer)*/, height: rectChange ? (CGFloat(widthheight[1] + 10)): CGFloat(widthheight[1]))
//                .padding(.horizontal) // idk why no padding expect thats what we got to do
            if let newimage = selecetedImage{
                HStack
                {
                    Spacer()
                        .frame(width: 4)
                    ImageView(uiImage: newimage, Big:false, widthheight: {
                        newval in
                        rectChange = true
                        widthheight = /*[Int(newimage.size.width), Int(newimage.size.width)]*/ newval
                        
                    })
                    VStack{
                        
                        Button(action:{selectedItem=nil;selecetedImage=nil;showtext=false; rectChange=false; widthheight = [240,45]}){
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundStyle(Color.brown)
                        }
                        .padding(.vertical)
                        Spacer()
                        
                    }
                    
                }
                .frame(height: CGFloat(widthheight[1] + 10))
            }
            if(!rectChange && liborphoto == nil){ // ie, if an image hasn't been selected, and a photo or camera hasn't been seelected, show
                Button(action:{libraryorImageCD.toggle()}){
                    selectYourPhoto(alrselected: false)
                }
                .confirmationDialog("Choose a photo or a take a photo", isPresented: $libraryorImageCD){
                    Button(action:{libraryorImageCD.toggle();liborphoto=true}){
                        Text("Choose a photo from your library")
                    }
                    Button(action:{libraryorImageCD.toggle();showcamera = true; }){
                        Text("Take a photo")
                    }
                }
            }
            
            
            if let x  = liborphoto {
                if(x && !rectChange){
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                        if(!(showtext)){
                            selectYourPhoto(alrselected: true)
                    }
                        
//                        if(rectChange==false){
//                                selectYourPhoto()
//                            }
                                
                        
                    }
                }
            }
                
        }
        .fullScreenCover(isPresented: $showcamera){
            theCameraView(theImage: {x in
                selecetedImage = x
                showcamera=false
            })
        }
        .onChange(of: selectedItem){oldvalue, newvalue in
                buffer = 12
                showtext = true
                libraryorImageCD = false
                liborphoto = nil
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
struct selectYourPhoto: View {
    var alrselected: Bool
    var body: some View {
        HStack(spacing: -4){
            Text( alrselected ? "Open photo library": "Select your photo")
                .foregroundStyle(Color.mutedgray)
                .frame(width: .infinity)
                .padding(.horizontal)
            Image(systemName: "photo")
                .foregroundStyle(Color.mutedgray)
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
    var width: CGFloat = .infinity
    var notSearching: Bool = true
    var body: some View {
        ZStack{
            brownRectangle(width: /*CGFloat(widthheigh[0])*/.infinity, height: CGFloat(widthheigh[1]))
            ZStack{
                Group{
                    if(isloggin){
                        TextField(/*"Recipe " +*/ inputtype, text: $input)
                            .foregroundStyle(Color.black)
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
                .frame(width: max(1,/*CGFloat(widthheigh[0]))*/.infinity), height: max(20,CGFloat(widthheigh[1])))
                
                
                HStack{
                    Spacer()
                    if(notSearching){
                        PasteButton(pasted: {
                            newval in input = newval
                        })

                    }
                    else{
                        sfSymbolImage(imageName: "magnifyingglass", imageColor: Color.primarybrown)
                    }
                }
                .frame(width: max(90,/*CGFloat(widthheigh[0])-10)*/ .infinity),height: max(10,CGFloat(widthheigh[1])-10))
                        .padding(.horizontal)
                
                
                
                
                
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

struct sfSymbolImage: View {
    var imageName: String
    var imageColor: Color
    var body: some View {
        Image(systemName: imageName)
            .foregroundStyle(imageColor)
        
    }
}

