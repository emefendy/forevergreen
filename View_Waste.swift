import Foundation
import SwiftUI


struct View_Waste: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var currentUserData: UserProfile?
    @State var waste: Double = 1
    @State private var selectedIndex: Int?
    
    
    var grams: Double {
        waste*0.7
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
                            Text("Waste")
                                .font(.custom("ArialRoundedMTBold", size: 35))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 30)
                            Image("trash")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 175)
                        }
                        Spacer().frame(width: 20)
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
                            Text("Rate your waste output today:")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            CustomSlider2(value: $waste, range: 1...5)
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
                            Spacer().frame(height: 20)
                        }
                        Spacer().frame(width: 30)
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
                        Spacer().frame(width: 30)
                    }
                    Spacer().frame(height: 30)
                    
                    HStack{
                        VStack{
                            Button {
                                Task {
                                    do {
                                        
                                        var wasteStat = WasteStat()
                                        wasteStat.waste = waste
                                        wasteStat.co2inGrams = grams
                                        wasteStat.co2inTons = ton
                                        if currentUserData != nil {
                                            self.currentUserData?.addDailyWasteStat(date: Date.now, wasteStat: wasteStat)
                                            //use below for testing
                                            //self.currentUserData?.copyTodayToYesterdayStat()
                                            try await UserDataManager.shared.updateUserData(userData: self.currentUserData ?? nil )
                                            
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
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width*1.05, height: UIScreen.main.bounds.height*0.9)
                
            }
        }.onAppear(){
            Task {
                do {
                    
                    print("submitted")
                    self.currentUserData = try await UserDataManager.shared.getUserData()
                }
                catch {
                    print(error)
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
        switch Int(waste) {
        case 1:
            return "Very Low (<1 kg)"
        case 2:
            return "Low (~1 kg)"
        case 3:
            return "Moderate (~2 kg)"
        case 4:
            return "High (~4 kg)"
        case 5:
            return "Very High (>4 kg)"
        default:
            return ""
        }
    }
    func getText2() -> String {
        switch Int(waste) {
        case 1:
            return "(e.g. few pieces of paper)"
        case 2:
            return "(e.g. some food peelings)"
        case 3:
            return "(e.g. trash from carry-out dining)"
        case 4:
            return "(e.g. one full trash can)"
        case 5:
            return "(e.g. 1+ trash bins of waste)"
        default:
            return ""
        }
    }
}







#Preview {
    View_Waste()
}
