import SwiftUI


struct View_Cumulative: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentUserData: UserProfile?
    
    @State private var electricityBillText: String = ""
    @State private var electricityBill: Double = 0.0
    @State private var gasBillText: String = ""
    @State private var gasBill: Double = 0.0
    @State private var electricityinvalid : String = ""
    @State private var gasinvalid : String = ""
    
    
    @State private var heatingBillText: String = ""
    @State private var heatingBill: Double = 0.0
    @State private var heatinginvalid : String = ""
    
    public var grams: Double {
        return 12*((electricityBill/0.08391)*390.0894382 + (gasBill/0.47464)*1 + (heatingBill/4.49/748*0.00378541)*10600)
    }
    
    var ton: Double {
        return grams*(0.000001)
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Spacer().frame(height: 20)
                    Text("Annual Carbon")
                        .font(.custom("ArialRoundedMTBold", size: 35))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 30)
                        .multilineTextAlignment(.center)
                    Text("Calculations:")
                        .font(.custom("ArialRoundedMTBold", size: 35))
                        .foregroundColor(Color("darkGreen"))
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 50)
                    Image("crispebacon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175, height: 175)
                    Spacer().frame(height: 20)
                    Text("Use this calculator to")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 30)
                        .multilineTextAlignment(.center)
                    Text("accurately calculate your")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .foregroundColor(Color("darkGreen"))
                        .multilineTextAlignment(.center)
                    Text("yearly carbon footprint!")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .foregroundColor(Color("darkGreen"))
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 30)
                    Divider().background(Color.darkGreen).frame(height: 3)
                    Spacer().frame(height: 20)
                    Text("Enter your electricity bill 🔌 from last month:")
                        .font(.custom("ArialRoundedMTBold", size: 15))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 30)
                        .multilineTextAlignment(.center)
                    HStack{
                        TextField("ex. 120 or 321.76", text: $electricityBillText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(height: 50)
                            .frame(width: 225)
                        
                            .font(.custom("ArialRoundedMTBold", size: 20))
                        Button(action: {
                            if let billAmount = Double(electricityBillText) {
                                electricityBill = billAmount
                                electricityinvalid = ""
                                print("Electricity Bill:", electricityBill)
                            } else {
                                electricityinvalid = "Please enter an integer or decimal number!"
                            }
                        }) {
                            Text("Submit")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkGreen)
                                .cornerRadius(12)
                                .padding(.horizontal, 15)
                        }
                        .frame(height: 50)
                        
                    }
                    Text("\(electricityinvalid)")
                    Text("Enter your natural gas bill ⛽ from last month:")
                        .font(.custom("ArialRoundedMTBold", size: 15))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                    HStack{
                        TextField("ex. 120 or 321.76", text: $gasBillText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(height: 50)
                            .frame(width: 225)
                        
                            .font(.custom("ArialRoundedMTBold", size: 20))
                        Button(action: {
                            if let billAmount = Double(gasBillText) {
                                gasBill = billAmount
                                gasinvalid = ""
                                print("Gas Bill:", gasBill)
                            } else {
                                gasinvalid = "Please enter an integer or decimal number!"
                            }
                        }) {
                            Text("Submit")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkGreen)
                                .cornerRadius(12)
                                .padding(.horizontal, 15)
                        }
                        .frame(height: 50)
                        
                    }
                    Text("\(gasinvalid)")
                    
                    
                    Text("Enter your water bill 💧 from last month:")
                        .font(.custom("ArialRoundedMTBold", size: 15))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 10)
                        .multilineTextAlignment(.center)
                    HStack{
                        TextField("ex. 120 or 321.76", text: $heatingBillText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(height: 50)
                            .frame(width: 225)
                        
                            .font(.custom("ArialRoundedMTBold", size: 20))
                        Button(action: {
                            if let billAmount = Double(heatingBillText) {
                                heatingBill = billAmount
                                heatinginvalid = ""
                                print("Heating Bill:", heatingBill)
                            } else {
                                heatinginvalid = "Please enter an integer or decimal number!"
                            }
                        }) {
                            Text("Submit")
                                .font(.custom("ArialRoundedMTBold", size: 15))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkGreen)
                                .cornerRadius(12)
                                .padding(.horizontal, 15)
                        }
                        .frame(height: 50)
                        
                    }
                    
                    
                    
                    Text("\(heatinginvalid)")
                    Spacer().frame(height: 20)
                    Text("Appoximately \(grams, specifier: "%.0f") grams")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .padding(.horizontal, 30)
                        .foregroundColor(Color("darkGreen"))
                    Text("(\(ton) metric tons)")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .padding(.horizontal, 30)
                        .foregroundColor(Color("darkGreen"))
                    Text("of CO2 emitted yearly!")
                        .font(.custom("ArialRoundedMTBold", size: 20))
                        .padding(.horizontal, 30)
                        .foregroundColor(Color("darkGreen"))
                    Spacer().frame(height: 20)
                    Button {
                        Task {
                            do {
                                var cumulativeStat = CumulativeStat()
                                cumulativeStat.co2inGrams = grams
                                cumulativeStat.co2inTons = ton
                                if currentUserData != nil {
                                    self.currentUserData?.addDailyCumulativeStat(date: Date.now, cumulativeStat: cumulativeStat)
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
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(width: 100)
                            .background (Color.darkGreen)
                            .cornerRadius(10)
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
        }
    }
}

struct View_House: View {
    var body: some View {
        VStack {
            Text("House View")
                .foregroundColor(.black)
            Spacer()
        }
        .navigationBarItems(
            leading: Button(action: {}) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .padding()
            }
        )
    }
}

struct View_Commute: View {
    var body: some View {
        VStack {
            Text("Commute View")
                .foregroundColor(.black)
            Spacer()
        }
        .navigationBarItems(
            leading: Button(action: {}) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .padding()
            }
        )
    }
}

struct View_Gardening: View {
    var body: some View {
        VStack {
            Text("Gardening View")
                .foregroundColor(.black)
            Spacer()
        }
        .navigationBarItems(
            leading: Button(action: {}) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .padding()
            }
        )
    }
}

struct View_Recycling: View {
    var body: some View {
        VStack {
            Text("Recycling View")
                .foregroundColor(.black)
            Spacer()
        }
        .navigationBarItems(
            leading: Button(action: {}) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .padding()
            }
        )
        
    }
}

struct View_Cumulative_Previews: PreviewProvider {
    static var previews: some View {
        View_Cumulative()
    }
}
