import SwiftUI




struct View_Transportation: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentUserData: UserProfile?
    @State var hours: Double = .zero
    @State var hi: Double = .zero
    @State private var selectedIndex: Int?
    
    var miles: Double {
        return hours * speed
    }
    
    
    var speed: Double {
        if selectedIndex == 0
        {
            return 12.5
        }
        else if selectedIndex == 1
        {
            return 38
        }
        else if selectedIndex == 2
        {
            return 63
        }
        return 0
    }
    
    var grams: Double {
        return 404*miles
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
                            Text("Transportation")
                                .font(.custom("ArialRoundedMTBold", size: 35))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 30)
                            Image("car")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 175, height: 175)
                        }
                    }
                    HStack{
                        VStack{
                            Text("Did you know? A typical passenger")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("vehicle emits about 4.6 metric")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .foregroundColor(Color("darkGreen"))
                            Text("tons of carbon dioxide per year!")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .foregroundColor(Color("darkGreen"))
                            
                            Spacer().frame(height: geometry.size.height * 0.02)
                            Divider().background(Color.darkGreen).frame(height: 3)
                            Spacer().frame(height: geometry.size.height * 0.02)
                            Text("What is YOUR footprint today?")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("How many hours did you")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 20)
                            Text("travel by car today? 🚗")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                            
                                .foregroundColor(Color("darkGreen"))
                            
                            
                            CustomSlider(value: $hours, range: 0...10)
                                .frame(height: 30)
                            HStack {
                                Spacer().frame(width: geometry.size.height * 0.03)
                                Text("0")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.leading) { _ in
                                        +10 // Adjust as necessary
                                    }
                                Spacer()
                                Text("10+ hours")
                                    .font(.custom("ArialRoundedMTBold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize))
                                    .alignmentGuide(.trailing) { _ in
                                        -10
                                    }
                                
                            }
                            
                        }
                        
                    }
                    HStack{
                        VStack{
                            Text("What speed were you driving,")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .padding(.horizontal, 20)
                                .foregroundColor(Color("darkGreen"))
                            Text("on average? 💨")
                                .font(.custom("ArialRoundedMTBold", size: 16))
                                .padding(.horizontal, 20)
                                .foregroundColor(Color("darkGreen"))
                            Spacer()
                            HStack(spacing: 10) {
                                RoundedButton(primaryText: "Low", secondaryText: "0 - 25 mph", color: .green, isSelected: selectedIndex == 0, action: { self.selectButton(0) })
                                RoundedButton(primaryText: "Medium", secondaryText: "26 - 50 mph", color: .green, isSelected: selectedIndex == 1, action: { self.selectButton(1) })
                                RoundedButton(primaryText: "High", secondaryText: "51 - 75 mph", color: .green, isSelected: selectedIndex == 2, action: { self.selectButton(2) })
                            }
                        }
                        
                    }
                    HStack{
                        VStack{
                            Text("\(hours, specifier: "%.0f") hours driven")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                                .padding(.top, 10)
                            Text("Appoximately \(miles, specifier: "%.0f") miles")
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.horizontal, 30)
                                .foregroundColor(Color("darkGreen"))
                            
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
                    HStack{
                        VStack{
                            Button {
                                Task {
                                    do {
                                        
                                        var transportStat = TransportationStat()
                                        transportStat.driving_hours = hours
                                        transportStat.avg_speed = speed
                                        transportStat.miles = miles
                                        transportStat.co2inGrams = grams
                                        transportStat.co2inTons = ton
                                        if currentUserData != nil {
                                            self.currentUserData?.addDailyTransportStat(date: Date.now, transportStat: transportStat)
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
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*1.1)
                
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
    
}




struct RoundedButton: View {
    var primaryText: String
    var secondaryText: String
    var color: Color
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Text(primaryText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
                Text(secondaryText)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(isSelected ? Color("darkGreen").opacity(0.6) : Color("darkGreen")))
        }
        .buttonStyle(PlainButtonStyle())
    }
}




#if DEBUG
struct View_Transportation_Previews: PreviewProvider {
    static var previews: some View {
        View_Transportation()
    }
}
#endif

struct CustomSlider: View {
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
                .gesture(DragGesture(minimumDistance: 0)
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
