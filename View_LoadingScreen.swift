import SwiftUI
import AVFoundation
import WebKit


struct GifImage: View {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                
                GifWebView(name: name, width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct GifWebView: UIViewRepresentable {
    private let name: String
    private let width: CGFloat
    private let height: CGFloat
    
    init(name: String, width: CGFloat, height: CGFloat) {
        self.name = name
        self.width = width
        self.height = height
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.contentMode = .scaleAspectFill
        webView.clipsToBounds = true
        return webView
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.contentMode = .scaleToFill
        uiView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    
}

struct View_LoadingScreen: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isDestinationViewActive = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack{
                GifImage("gif")
                    .onAppear {
                        playAudio()
                    }
                GeometryReader { geometry in
                    Image("blue")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height / 9)
                        .edgesIgnoringSafeArea(.top)
                }
                VStack {
                    Spacer()
                    
                    Image("logos")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                        .edgesIgnoringSafeArea(.bottom)
                }
                ZStack{
                    VStack{
                        Spacer().frame(height: 470)
                        Button(action: {
                            self.isDestinationViewActive = true
                        }) {
                            ZStack {
                                Image("start")
                                    .scaleEffect(0.75)
                                
                            }
                        }
                        .fullScreenCover(isPresented: $isDestinationViewActive) {
                            RootView()
                        }
                    }
                }
                
                
                
                
            }
        }
        
    }
    
    
    
    
    func playAudio() {
        let soundName = "music"
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Could not read file named \(soundName)")
            return
        }
        do {
            if let player = audioPlayer {
                player.numberOfLoops = -1
                player.play()
            } else {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            }
        } catch {
            print("ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

struct View_LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        View_LoadingScreen()
    }
}
