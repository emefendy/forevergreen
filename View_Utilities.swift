import Foundation
import SwiftUI


struct View_Utilities: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentUserData: UserProfile?
    @State var water: Double = 1
    @State var electricity: Double = 1
    @State var hi: Double = .zero
    @State private var selectedIndex: Int?
    
    
    var grams: Double {
        water*802.50692 + electricity*390.0894
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
                            Text("Utilities")
                                .font(.custom("ArialRoundedMTBold", size: 35))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 30)
                            Image("faucet")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 175)
                        }
                    }
                    HStack{
                        VStack{
                            Text("Did you know? On average, over")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("25% of the water entering a building")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            Text("goes to waste!")
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
                            //
                            Text("Rate your water usage today:")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            CustomSlider2(value: $water, range: 1...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("1")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            Text("\(getText())")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            Text("\(getText2())")
                                .font(.custom("ArialRoundedMT", size: 15))
                                .foregroundColor(Color("darkGreen"))
                            //
                            Text("Rate your electricity usage today:")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            CustomSlider2(value: $electricity, range: 1...5)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("1")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10
                                    }
                                Spacer()
                                Text("5")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                Spacer().frame(width: 10)
                            }
                            
                            Text("\(getText3())")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                            Text("\(getText4())")
                                .font(.custom("ArialRoundedMT", size: 15))
                                .foregroundColor(Color("darkGreen"))
                            
                            
                            
                            Spacer().frame(height: 20)
                            
                            
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
                                        
                                        var utilityStat = UtilityStat()
                                        utilityStat.water = water
                                        utilityStat.electricity = electricity
                                        utilityStat.co2inGrams = grams
                                        utilityStat.co2inTons = ton
                                        if currentUserData != nil {
                                            currentUserData?.addDailyUtilityStat(
                                                date: Date.now, utilityStat: utilityStat)
                                            
                                            try await UserDataManager.shared.updateUserData(userData: currentUserData ?? nil )
                                            
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
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*1.1)
                
            }.onAppear(){
                Task {
                    do {
                        
                        print("reload user data")
                        self.currentUserData = try await UserDataManager.shared.getUserData()
                    }
                    catch {
                        print(error)
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
    func getText() -> String {
        switch Int(water) {
        case 1:
            return "Very Low (~20 gal)"
        case 2:
            return "Low (~40 gal)"
        case 3:
            return "Moderate (~60 gal)"
        case 4:
            return "High (~80 gal)"
        case 5:
            return "Very High (100+ gal)"
        default:
            return ""
        }
    }
    func getText2() -> String {
        switch Int(water) {
        case 1:
            return "(e.g. drinking water only)"
        case 2:
            return "(e.g. washed dishes)"
        case 3:
            return "(e.g. ran washing machine)"
        case 4:
            return "(e.g. took bath, ran lots of sprinklers)"
        case 5:
            return "(e.g. hosted a water gun party)"
        default:
            return ""
        }
    }
    func getText3() -> String {
        switch Int(electricity) {
        case 1:
            return "Very Low (~10 kWh)"
        case 2:
            return "Low (~20 kWh)"
        case 3:
            return "Moderate (~30 kWh)"
        case 4:
            return "High (~40 kWh)"
        case 5:
            return "Very High (50+ kWh)"
        default:
            return ""
        }
    }
    func getText4() -> String {
        switch Int(electricity) {
        case 1:
            return "(e.g. little to minimal lighting)"
        case 2:
            return "(e.g. few lightbulbs)"
        case 3:
            return "(e.g. lighting for average two-story house)"
        case 4:
            return "(e.g. running Christmas lights)"
        case 5:
            return "(e.g. lighting a mansion)"
        default:
            return ""
        }
    }
    
}

struct CustomSlider2: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.pink]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: geometry.size.width, height: 16)
                    .cornerRadius(8)
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .shadow(radius: 2)
                    Text("\(Int(self.value))")
                        .font(.system(size: 11))
                        .foregroundColor(.black)
                }
                .frame(width: 30, height: 30)
                .offset(x: self.thumbOffset(in: geometry.size.width))
                .gesture(DragGesture(minimumDistance: 1)
                    .onChanged { value in
                        self.updateValue(at: value.location.x, width: geometry.size.width)
                    }
                )
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
    
    private func thumbOffset(in width: CGFloat) -> CGFloat {
        let percentage = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        return percentage * (width - 30)
    }
    
    private func updateValue(at location: CGFloat, width: CGFloat) {
        let percentage = Double(location / width)
        let newValue = percentage * (range.upperBound - range.lowerBound) + range.lowerBound
        self.value = min(max(newValue, range.lowerBound), range.upperBound)
    }
}



#Preview {
    View_Utilities()
}
