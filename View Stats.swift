import SwiftUI

struct View_Stats: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var currentUserData: UserProfile?
    @State var transportCo2: Double?
    @State var utilityCo2: Double?
    @State var foodCo2: Double?
    @State var wasteCo2: Double?
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Welcome back!")
                        .font(.custom("ArialRoundedMTBold", size: 35))
                        .padding(.horizontal, 30)
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                    Spacer().frame(height: geometry.size.height * 0.02)
                    Divider().background(Color.darkGreen).frame(height: 1)
                    Spacer().frame(height: geometry.size.height * 0.005)
                    Text("Your daily statistics:")
                        .font(.custom("ArialRoundedMTBold", size: 25))
                        .padding(.horizontal, 30)
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                    VStack{
                        Spacer().frame(height: geometry.size.height * 0.01)
                        HStack {
                            Spacer().frame(width: 15)
                            NavigationLink(destination: View_Transportation()) {
                                ZStack {
                                    Image("redBox")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 175, height: 175)
                                    Text("\n\(transportCo2 ?? 0, specifier: "%.0f")")
                                        .font(.custom("ArialRoundedMTBold", size: 30))
                                        .padding(.horizontal, -50)
                                        .foregroundColor(Color("darkGreen"))
                                    Text("\n\n\n\n\ngrams of CO2")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color("darkGreen"))
                                    Color.black.opacity(0)
                                        .frame(width: 175, height: 175)
                                        .cornerRadius(12)
                                    
                                }
                            }
                            NavigationLink(destination: View_Food()) {
                                ZStack {
                                    Image("orangeBox")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .padding(.horizontal, 40)
                                        .frame(width: 175, height: 175)
                                    Text("\n\(foodCo2 ?? 0, specifier: "%.0f")")
                                        .font(.custom("ArialRoundedMTBold", size: 30))
                                        .padding(.horizontal, -50)
                                        .foregroundColor(Color("darkGreen"))
                                    Text("\n\n\n\n\ngrams of CO2")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color("darkGreen"))
                                    Color.black.opacity(0)
                                        .frame(width: 175, height: 175)
                                        .cornerRadius(12)
                                    
                                }
                            }
                            
                        }
                        Spacer().frame(height: geometry.size.height * 0.01)
                        HStack {
                            Spacer().frame(width: 15)
                            NavigationLink(destination: View_Utilities()) {
                                ZStack {
                                    Image("blueBox")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .padding(.horizontal, 70)
                                        .frame(width: 175, height: 175)
                                    Text("\n\(utilityCo2 ?? 0, specifier: "%.0f")")
                                        .font(.custom("ArialRoundedMTBold", size: 30))
                                        .padding(.horizontal, -50)
                                        .foregroundColor(Color("darkGreen"))
                                    Text("\n\n\n\n\ngrams of CO2")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color("darkGreen"))
                                    Color.black.opacity(0)
                                        .frame(width: 175, height: 175)
                                        .cornerRadius(12)
                                    
                                }
                            }
                            NavigationLink(destination: View_Waste()) {
                                ZStack {
                                    Image("purpleBox")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .padding(.horizontal, 40)
                                        .frame(width: 175, height: 175)
                                    Text("\n\(wasteCo2 ?? 0, specifier: "%.0f")")
                                        .font(.custom("ArialRoundedMTBold", size: 30))
                                        .padding(.horizontal, -50)
                                        .foregroundColor(Color("darkGreen"))
                                    Text("\n\n\n\n\ngrams of CO2")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color("darkGreen"))
                                    Color.black.opacity(0)
                                        .frame(width: 175, height: 175)
                                        .cornerRadius(12)
                                    
                                }
                            }
                        }
                    }
                    //Spacer()
                    
                    Text("Earn 100 points for every daily improvement in total carbon footprint! Gain 1000 points to level up!")
                        .font(.custom("ArialRoundedMTBold", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 10)
                    NavigationLink(destination: View_Cumulative()) {
                        Text("Calculate your yearly carbon footprint here!")
                            .font(.custom("ArialRoundedMTBold", size: 15))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 360)
                            .background(Color.darkGreen)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                            .padding(.top, 10)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }.tint(Color("darkGreen"))
                
                
            }.onAppear(){
                Task{
                    do {
                        
                        print("submitted")
                        currentUserData = try await UserDataManager.shared.getUserData()
                        if currentUserData != nil {
                            transportCo2 = currentUserData?.getTodayStat().transportation?.co2inGrams
                            utilityCo2 = currentUserData?.getTodayStat().utility?.co2inGrams
                            foodCo2 = currentUserData?.getTodayStat().food?.co2inGrams
                            wasteCo2 = currentUserData?.getTodayStat().waste?.co2inGrams
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}

