import SwiftUI


struct View_Resources: View {
    @State private var topCurrentIndex = 0
    @State private var bottomCurrentIndex = 0
    
    let topImages = ["article one", "article two", "article three", "article four"]
    let bottomImages = ["video one", "video two", "video three", "video four"]
    
    let topHyperlinks = ["https://forevergreenapp.wixsite.com/forevergreen/post/how-politics-confounds-progress-in-environmental-change", "https://forevergreenapp.wixsite.com/forevergreen/post/why-the-us-is-lagging-behind-in-sustainable-practices", "https://forevergreenapp.wixsite.com/forevergreen/post/the-benefits-of-using-eco-friendly-products", "https://forevergreenapp.wixsite.com/forevergreen/post/10-easy-ways-to-reduce-your-carbon-footprint"]
    
    let bottomHyperlinks = ["https://www.youtube.com/watch?v=bYb7YLsXvzg", "https://www.ted.com/talks/matthew_tolley_how_to_reduce_your_carbon_footprint_by_80", "https://www.youtube.com/watch?v=jXCZ9MFBBp4", "https://www.youtube.com/watch?v=aCu9rZvXRLg"]
    
    var body: some View {
        VStack {
            
            Text("Resources 📖")
                .font(.custom("ArialRoundedMTBold", size: 35))
                .foregroundColor(Color("darkGreen"))
                .padding(.top, 10)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 20)
            Divider().background(Color.darkGreen).frame(height: 3)
            Spacer().frame(height: 20)
            Text("Educational Articles")
                .font(.custom("ArialRoundedMTBold", size: 20))
                .padding(.top, 1)
                .foregroundColor(Color("darkGreen"))
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(0..<self.topImages.count) { index in
                                    Image(self.topImages[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                                        .clipped()
                                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                        .onTapGesture {
                                            self.openURL(urlString: self.topHyperlinks[index])
                                        }
                                        .frame(width: geometry.size.width)
                                }
                            }
                        }
                        .content.offset(x: -geometry.size.width * CGFloat(self.topCurrentIndex))
                        .frame(width: geometry.size.width, alignment: .leading)
                        .gesture(DragGesture()
                            .onEnded({ (value) in
                                if value.translation.width < 0 {
                                    if self.topCurrentIndex < self.topImages.count - 1 {
                                        withAnimation {
                                            self.topCurrentIndex += 1
                                        }
                                    }
                                }
                                if value.translation.width > 0 {
                                    if self.topCurrentIndex > 0 {
                                        withAnimation {
                                            self.topCurrentIndex -= 1
                                        }
                                    }
                                }
                            }))
                        
                        
                        VStack {
                            HStack {
                                Spacer().frame(width: 25)
                                Button(action: {
                                    if self.topCurrentIndex > 0 {
                                        withAnimation {
                                            self.topCurrentIndex -= 1
                                        }
                                    }
                                }) {
                                    Image(systemName: "chevron.left.circle")
                                        .font(.largeTitle)
                                        .foregroundColor(Color("darkGreen"))
                                    
                                }
                                Spacer().frame(width: 275)
                                Button(action: {
                                    if self.topCurrentIndex < self.topImages.count - 1 {
                                        withAnimation {
                                            self.topCurrentIndex += 1
                                        }
                                    }
                                }) {
                                    Image(systemName: "chevron.right.circle")
                                        .font(.largeTitle)
                                        .foregroundColor(Color("darkGreen"))
                                }
                                Spacer().frame(width: 20)
                                
                            }
                            Spacer().frame(height: 100)
                        }
                    }
                }
            }
            
            Spacer()
                .frame(height: 10)
            
            Text("Educational Videos")
                .font(.custom("ArialRoundedMTBold", size: 20))
                .padding(.top, 1)
                .foregroundColor(Color("darkGreen"))
            GeometryReader { geometry in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0..<self.bottomImages.count) { index in
                                Image(self.bottomImages[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                                    .clipped()
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                    .onTapGesture {
                                        self.openURL(urlString: self.bottomHyperlinks[index])
                                    }
                                    .frame(width: geometry.size.width)
                            }
                        }
                    }
                    .content.offset(x: -geometry.size.width * CGFloat(self.bottomCurrentIndex))
                    .frame(width: geometry.size.width, alignment: .leading)
                    .gesture(DragGesture()
                        .onEnded({ (value) in
                            if value.translation.width < 0 {
                                if self.bottomCurrentIndex < self.bottomImages.count - 1 {
                                    withAnimation {
                                        self.bottomCurrentIndex += 1
                                    }
                                }
                            }
                            if value.translation.width > 0 {
                                if self.bottomCurrentIndex > 0 {
                                    withAnimation {
                                        self.bottomCurrentIndex -= 1
                                    }
                                }
                            }
                        }))
                    
                    VStack {
                        HStack {
                            Spacer().frame(width: 25)
                            Button(action: {
                                if self.bottomCurrentIndex > 0 {
                                    withAnimation {
                                        self.bottomCurrentIndex -= 1
                                    }
                                }
                            }) {
                                Image(systemName: "chevron.left.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(Color("darkGreen"))
                                
                            }
                            Spacer().frame(width: 275)
                            Button(action: {
                                if self.bottomCurrentIndex < self.bottomImages.count - 1 {
                                    withAnimation {
                                        self.bottomCurrentIndex += 1
                                    }
                                }
                            }) {
                                Image(systemName: "chevron.right.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(Color("darkGreen"))
                            }
                            Spacer().frame(width: 30)
                            
                        }
                        Spacer().frame(height: 120)
                    }
                    
                }
            }
        }
    }
    
    private func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid URL")
        }
    }
}
