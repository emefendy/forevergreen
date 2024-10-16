import SwiftUI


struct View_Food: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentUserData: UserProfile?
    @State var beefservings: Double = .zero
    @State var porkservings: Double = .zero
    @State var chickenservings: Double = .zero
    @State var lambservings: Double = .zero
    @State var prawnservings: Double = .zero
    @State var cheeseservings: Double = .zero
    
    @State var hi: Double = .zero
    @State private var selectedIndex: Int?
    
    
    var grams: Double {
        beefservings*15500 + porkservings*2400 + chickenservings*1820 + cheeseservings*2790 + lambservings*5840 + prawnservings*4070
    }
    
    var ton: Double {
        return grams*(0.000001)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack {
                    HStack{
                        VStack{
                            Spacer().frame(height: 30)
                            Text("Food")
                                .font(.custom("ArialRoundedMTBold", size: 35))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 30)
                            Image("food")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 175)
                        }
                        Spacer().frame(width: 20)
                    }
                    HStack{
                        VStack{
                            Text("Did you know? 30% of all")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("greenhouse gas emissions come")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            Text("from food-system emissions! 😱")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            Spacer().frame(height: geometry.size.height * 0.02)
                            Divider().background(Color.darkGreen).frame(height: 3)
                            Spacer().frame(height: geometry.size.height * 0.02)
                            Text("What is YOUR footprint today?")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("How many servings of beef (100g)")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("did you eat today? 🐄")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $beefservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            
                            Text("Cheese? 🧀")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $cheeseservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            Text("Pork? 🐖")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $porkservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            Text("Chicken? 🐔")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $chickenservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            
                            
                            Text("Lamb? 🐑")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $lambservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            Text("Prawn? 🦐")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            CustomSlider(value: $prawnservings, range: 0...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5+ servings")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    HStack{
                        VStack{
                            Text("Appoximately \(grams, specifier: "%.0f") grams")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            Text("(\(ton) metric tons)")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            Text("of CO2 emitted")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            
                            
                        }
                        
                    }
                    Spacer().frame(height: 30)
                    
                    
                    HStack{
                        VStack{
                            Button {
                                Task {
                                    do {
                                        var foodStat = FoodStat()
                                        foodStat.beefservings = beefservings
                                        foodStat.porkservings = porkservings
                                        foodStat.chickenservings = chickenservings
                                        foodStat.lambservings = lambservings
                                        foodStat.prawnservings = prawnservings
                                        foodStat.cheeseservings = cheeseservings
                                        foodStat.co2inGrams = grams
                                        foodStat.co2inTons = ton
                                        
                                        if self.currentUserData != nil {
                                            self.currentUserData?.addDailyFoodStat(
                                                date: Date.now, foodStat: foodStat)
                                            
                                            try await UserDataManager.shared.updateUserData(
                                                userData: self.currentUserData ?? nil )
                                            
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                        return
                                    }
                                    catch {
                                        print(error)
                                    }
                                }
                                
                            } label: {
                                Text("Submit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                                    .frame(width: 100)
                                    .background (Color.darkGreen)
                                    .cornerRadius(10)
                            }
                        }
                        
                    }
                    
                    Spacer().frame(height: 30)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*1.4)
                
            }.onAppear(){
                Task {
                    do {
                        print("load user data")
                        self.currentUserData = try await UserDataManager.shared.getUserData()
                    }
                    catch {
                        print("view_food error:\(error)")
                    }
                }
            }
            
        }
        
    }
    func selectButton(_ index: Int) {
        if selectedIndex == index {
            selectedIndex = nil
        } else {
            selectedIndex = index
        }
    }
    
}




#if DEBUG
struct View_Food_Previews: PreviewProvider {
    static var previews: some View {
        View_Food()
    }
}
#endif
