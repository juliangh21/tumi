struct Ranker: View {
//    var rank: Int
    var rank: String
    var recipe_name: String
    var recipe_type: String
    var rectwidth: Double = 340
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 9)
                .fill(.brown)
                .frame(width: CGFloat(rectwidth),height: 80)
//            Text("1")
//                .font(.largeTitle)
//                .padding(.trailing, CGFloat(rectwidth - (0.20*rectwidth)))
//                .padding()
//                .frame(maxWidth:.infinity, alignment: .leading)
            infoView(rank: rank, recipe_name: recipe_name, recipe_type: recipe_type, rect_width: rectwidth, rect_height: 80)
                .padding(.leading)
        }
    
    }
}

struct infoView: View {
    var rank: String
//    var rank: Int
    var recipe_name: String
    var recipe_type: String
    var rect_width: Double
    var rect_height: Double
    var body: some View {
        HStack(){
            Text(String(rank)+".")
                .font(.largeTitle)
//                .padding(.trailing)
//                .frame(width: 340/5)
            Spacer()
            Text(recipe_name)
                .font(.body)
            Spacer()
            Spacer()
            Spacer()
            Text(recipe_type)
                .font(.footnote)
            
        }
        
        .frame(width: CGFloat((rect_width*0.85)), height: CGFloat((rect_height*0.8)))
    }
}