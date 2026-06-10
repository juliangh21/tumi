//
//  Ranker.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 3/8/26.
//
import SwiftUI
import FirebaseAnalytics
struct Ranker: View { // view for data from recipe and the rectangle. This is the final card
    @EnvironmentObject var router: appRouter
    var theRecipe: Recipe
    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rectwidth: Double = 340
    var body: some View {
        Button(action: {print("tapped");router.goTo(to: .recipe(theRecipe)) }) {
//            router.goTo(to: .recipe(theRecipe))
            ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 9)
                    .fill(Color.primarybrown)
                    .frame(width: CGFloat(rectwidth),height: 80)
                Text(String(theRecipe.getRank())+".")
    //                .font(.largeTitle)
                    .font(.system(size: 80))
                    .frame(width: 100, height: 0)
    //                .font(.headline)
                    .foregroundStyle(Color.darkbrownimpactfont)
                infoView(theRecipe: theRecipe, rank: rank, recipe_name: recipe_name, recipe_type: recipe_type, rect_width: rectwidth, rect_height: 80)
//                    .padding(.leading)
            }
            
        }
        
    
    }
}

struct infoView: View { // this is the view for the data from recipe. NOT THE RECTANGLE variables are taken in as parameters and displatd
    var theRecipe: Recipe
    var rank: Int
//    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rect_width: Double
    var rect_height: Double
    @State var theImage: UIImage?
    var body: some View {
        HStack(alignment: .center){
            Spacer()
                .frame(width:90, height:0)
//            Text(String(rank)+".")
////                .font(.largeTitle)
//                .font(.system(size: 80))
//                .frame(width: 90)
////                .font(.headline)
//                .foregroundStyle(Color.darkbrownimpactfont)
////                .padding(.trailing)
////                .frame(width: 340/5)
////            Spacer() //spacer to make sure its in the left quarter
            Spacer()
                .frame(width:6, height: 0)
            VStack(alignment: .leading){
                Text(recipe_name)
//                    .font(.body)
                    .font(.system(size:20))
                    .foregroundStyle(Color.brownfont)
                    .bold()
                Text(recipe_type)
                    .font(.system(size:12))
                    .foregroundStyle(Color.secondaryfont)
                //                .font(.footnote)
                //                .foregroundStyle(Color.secondaryfont)
            }
//            Text(recipe_name)
//                .font(.body)
//                .foregroundStyle(Color.brownfont)
//            Spacer()
            Spacer()
                .frame(width:20)
//            Spacer()
            if(theImage != nil){
                imageFancyView(UIimage1: theImage! )
                    .offset(x:26, y:7)
//                    .clipped(false, antialiased: true)
            }
            else{
                turntRectangle()
            }
            
//            Spacer()
//            Text(recipe_type)
//                .font(.footnote)
//                .foregroundStyle(Color.secondaryfont)
            
        }
        .task {
            print("Task started")
            if let imageData = theRecipe.Image {
                theImage = UIImage(data: theRecipe.Image!)
                print("image is new")
                
            } else if let urlString = theRecipe.imageURL,
                      
                      let url = URL(string: urlString) {
                print("Image recieved")
                do{
                    print("Image loaded")
                    let (data, _) = try await URLSession.shared.data(from: url)
                    theImage = UIImage(data: data)
                }
                catch{
                    print("Error \(error)")
                }
                
                }
//            theImage = nil
            print("WHAT IS happening")
        }
        .frame(width: CGFloat((rect_width*0.85)), height: CGFloat((rect_height*0.8)))
    }
}


struct ImageView: View {
    var uiImage: UIImage
    var Big: Bool
    var widthheight: ([Int]) -> Void
    var body: some View {
//        if(Big){
            let height: CGFloat = Big ? 250 : 125
            let aspectRatio = uiImage.size.width / uiImage.size.height
            let width = height * aspectRatio
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .frame(width: width, height: height)
                .analyticsScreen(name: "Image added")
                .onGeometryChange(for: CGSize.self) { proxy in
                                    proxy.size
                                } action: { newValue in
                                    widthheight([Int(newValue.width), Int(newValue.height)])
                                }
//        }
//        else{
//            Image(uiImage: uiImage)
//                .resizable()
//                .scaledToFill()
//                .clipShape(RoundedRectangle(cornerRadius: 9))
//                .frame(width: 50, height: 125)
//                .onGeometryChange(for: CGSize.self) { proxy in
//                                    proxy.size
//                                } action: { newValue in
//                                    widthheight([Int(newValue.width), Int(newValue.height)])
//                                }
//        }
        
    }
}

struct imageFancyView: View {
    var UIimage1: UIImage
//    let x= [10,15,20,50,]
    var body: some View {
        ZStack{
//            Image(uiImage:UIimage)
//                .resizable()
//                .scaledToFill()
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .frame(width: 50,height: 50)
//            RoundedRectangle(cornerRadius: 16)
//                .frame(width:86, height: 86)
//                .rotationEffect(Angle(degrees: 50), anchor: .bottomTrailing)
////                .offset(x: offsetAngle(angle: Angle.degrees(-51))[0],y: offsetAngle(angle: Angle.degrees(-51))[1])
////            RoundedRectangle(cornerRadius: 16)
////                .frame(width:50, height: 50)
////                .foregroundStyle(.blue)
////                .offset(x: offsetAngle(angle: Angle.degrees(-30))[0],y: offsetAngle(angle: Angle.degrees(-30))[1])
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundStyle(.red)
//                .frame(width:86, height: 86)
//                .rotationEffect(Angle(degrees: 30), anchor: .bottomTrailing)
//                .rotationEffect(Angle(degrees: -5,1), anchor: .bottomTrailing)
            Image(uiImage: UIimage1)
//            RoundedRectangle(cornerRadius: 16)
                .resizable()
                .scaledToFill()
                .frame(width:86, height: 86)
                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .foregroundStyle(.blue)
                .rotationEffect(Angle(degrees: Double.random(in:-25...25)),anchor: .bottomTrailing)
//                .rotationEffect(Angle(degrees: -51), anchor: .bottomTrailing)
//                .offset(x: offsetAngle(angle: Angle.degrees(30      ))[0],y: offsetAngle(angle: Angle.degrees(3000))[1])
        }
        
        
    }
}
struct turntRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width:86, height: 86)
            .rotationEffect(Angle(degrees: 50), anchor: .bottomTrailing)
            .foregroundStyle(.clear)
    }
}
//#Preview{
//    
//    ZStack(alignment: .leading){
//        RoundedRectangle(cornerRadius: 9)
//            .fill(Color.primarybrown)
//            .frame(width: CGFloat(340),height: 80)
//        infoView(, rank: 1, recipe_name: "Pico De Gallo", recipe_type: "Salad", rect_width: 340, rect_height: 80)
//    }
//}
struct recipeView: View {
    var recipeList: [Recipe]
    @State var theRecipe: Recipe
    @State var editsheetshowing = false
    @State var ranksheetshowing = false
    @State var recipeImage: UIImage?
    var newRecipe: (RecipeViewStruct) -> Void
    
//    var oldrecipeIndex: (String) -> Void
    var body: some View {
            ZStack{
                Color.lightbrownbkgrnd.ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 1 ){
                        Button(action: {editsheetshowing=true}){
                            ZStack{
                                    RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.accentorange)
                                    .frame(width: CGFloat(80),height: 30)
                                    Text("Edit")
                                    .foregroundStyle(Color.white)
                                    .analyticsScreen(name: "WORK HOLY CRAP")
                                }

                        }
                        .frame(maxWidth:.infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .sheet(isPresented: $editsheetshowing ){
                            addSheet(theRecipe: theRecipe, isCreating: false, recipelist: recipeList, recipeAdded: { recipenew in
                                let oldRecipe = theRecipe
                                theRecipe = recipenew
                                editsheetshowing = false
                                let bothRecipes = RecipeViewStruct(newRecipe: recipenew, oldRecipe: oldRecipe)
                                newRecipe(bothRecipes)
                            })
                            .presentationDetents([.medium, .large])
                        }
                        .presentationDetents([.medium, .large])
                        
                            if(theRecipe.getSourceString() != ""){
                                HStack(spacing:1){
                                    Link(destination: URL(string: theRecipe.getSourceString())!,){
                                        BigTextView(input: theRecipe.recipeName)
                                            .padding([.horizontal], -30)
                                    }
                                    Image(systemName: "link")
                                        .font(.system(size:40))
                                        .foregroundStyle(Color.brownfont)
                                }
                                .padding([.horizontal], 30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            else{
                                BigTextView(input: theRecipe.recipeName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        if (recipeImage != nil){
                            ImageView(uiImage: recipeImage!, Big: true, widthheight: {newval in print(newval)})
//                            Image(uiImage: theRecipe.getImage())
//                                .resizable()
//                                .scaledToFill()
//                                .clipShape(RoundedRectangle(cornerRadius: 9))
//                                .frame(width: 100, height: 250)
                        }
                        Text("Made on " + String(theRecipe.datecreated.formatted()))
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                            .foregroundStyle(Color.secondaryfont)
                        HStack(spacing: 5){
                            Text("Currently ranked " + theRecipe.getRankwsuffix()+".")
                                .foregroundStyle(Color.secondaryfont)
                            Button(action: {ranksheetshowing=true}){
                                Text("Change that")
                                    .underline()
                                    .foregroundStyle(Color.secondaryfont)
                            }
                            .sheet(isPresented: $ranksheetshowing){
                                RankSheetView(recipeList: recipeList, newRecipe: theRecipe, rankclosureout: {
                                    finalRank in
//                                    theRecipe.changeRank(newRank: finalRank)
                                    let oldRecipe = theRecipe
                                    theRecipe.changeRank(newRank: finalRank)
                                    print(finalRank)
                                    print(theRecipe.getRankwsuffix())
                                    ranksheetshowing = false
                                    let bothRecipes = RecipeViewStruct(newRecipe: theRecipe, oldRecipe: oldRecipe)
                                    newRecipe(bothRecipes)
                                })
                                .presentationDetents([.medium, .large])
                            }
                            .presentationDetents([.medium, .large])
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .task {
                        print("Task started")
                        if let imageData = theRecipe.Image {
                            recipeImage = UIImage(data: theRecipe.Image!)
                            print("image is new")
                            
                        } else if let urlString = theRecipe.imageURL,
                                  
                                  let url = URL(string: urlString) {
                            print("Image recieved")
                            do{
                                print("Image loaded")
                                let (data, _) = try await URLSession.shared.data(from: url)
                                recipeImage = UIImage(data: data)
                            }
                            catch{
                                print("Error \(error)")
                            }
                            
                            }
            //            theImage = nil
                        print("WHAT IS happening")
                    }
                    
                    
                }
//                .frame(maxWidth: .infinity, maxHeight:.infinity)
            }
            
        
    }
}


//func loadImage(@Binding recipeImage: UIImage?, theRecipe: Recipe){
//    print("Task started")
//    if let imageData = theRecipe.Image {
//        recipeImage = UIImage(data: theRecipe.Image!)
//        print("image is new")
//        
//    } else if let urlString = theRecipe.imageURL,
//              
//              let url = URL(string: urlString) {
//        print("Image recieved")
//        do{
//            print("Image loaded")
//            let (data, _) = try await URLSession.shared.data(from: url)
//            recipeImage = UIImage(data: data)
//        }
//        catch{
//            print("Error \(error)")
//        }
//        
//        }
////            theImage = nil
//    print("WHAT IS happening")
//}
