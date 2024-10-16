import SwiftUI

struct GalleryItem: View {
    
    
    
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 175, height: 175)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
    }
}


struct View_Gallery: View {
    @State private var currentUserData: UserProfile?
    @State var level: Int = 1
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack{
                    Text("My Real Life Trees")
                        .font(.custom("ArialRoundedMTBold", size: 35))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 30)
                    
                    
                    Divider().background(Color.darkGreen).frame(height: 3)
                    Text("By using For Evergreen, you are making a REAL impact! 🎉🥳")
                        .font(.custom("ArialRoundedMTBold", size: 23))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 20)
                    Image("crispebacon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175, height: 175)
                    Text("Thanks to users like you, our partner,")
                        .font(.custom("ArialRoundedMTBold", size: 16))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                    Text("The Tree Club, is able to plant real trees! ")
                        .font(.custom("ArialRoundedMTBold", size: 16))
                        .foregroundColor(Color("darkGreen"))
                        .multilineTextAlignment(.center)
                    Text("In this gallery, you will find all the trees")
                        .font(.custom("ArialRoundedMTBold", size: 16))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                    Text("you have helped to plant by using our app.")
                        .font(.custom("ArialRoundedMTBold", size: 16))
                        .foregroundColor(Color("darkGreen"))
                        .multilineTextAlignment(.center)
                    Text("Level up to unlock more trees!")
                        .font(.custom("ArialRoundedMTBold", size: 25))
                        .foregroundColor(Color("darkGreen"))
                        .padding(.top, 20)
                    
                }
                .task{
                    do {
                        print("load user data")
                        self.currentUserData = try await UserDataManager.shared.getUserData()
                        self.level = self.currentUserData?.level ?? 1
                        print("level = \(self.level)")
                    } catch {
                        print(error)
                    }
                }
                ZStack {
                    VStack(spacing: 10) {
                        ForEach(0..<4) { index in
                            HStack(spacing: 13) {
                                ForEach(0..<2) { subIndex in
                                    if (index * 2 + subIndex + 1) <= level {
                                        GalleryItem(imageName: "tree\(index * 2 + subIndex + 1)")
                                    } else {
                                        Image("lock")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 175, height: 175)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .clipped()
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 20)
                    
                    
                    
                }
            }
            
            
        }.frame(height: UIScreen.main.bounds.height * 0.8)
    }
}

struct View_Gallery_Previews: PreviewProvider {
    static var previews: some View {
        View_Gallery()
    }
}
