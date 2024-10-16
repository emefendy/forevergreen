import SwiftUI
import SplineRuntime

struct View_Forest: View {
    @State private var currentUserData: UserProfile?
    @State var percent = Double (0.0)
    @State var level:Int = 1
    @State var levelUrl:String?
    @State var levelView: SplineView?
    
    
    var body: some View {
        ZStack{
            VStack{
                
            }.task{
                do {
                    print("load user data")
                    self.currentUserData = try await UserDataManager.shared.getUserData()
                    self.level = self.currentUserData?.level ?? 1
                    print("level = \(level)")
                    self.levelUrl = getLevel(level: self.level)
                } catch {
                    print(error)
                }
            }
            
            VStack {
                let url = URL(string: getLevel(level: self.level ?? 1))
                try? SplineView(sceneFileURL:  url!)
                    .ignoresSafeArea()
            }.task{
                do {
                    print("load user data")
                    self.currentUserData = try await UserDataManager.shared.getUserData()
                    let level = self.currentUserData?.level ?? 1
                    print("level = \(level)")
                    self.levelUrl = getLevel(level: level)
                } catch {
                    print(error)
                }
            }
            
            VStack{
                Spacer().frame(height: 60)
                HStack {
                    
                    ProgressBar(width: 300, height: 30, percent: self.percent, color1: Color.yellow, color2: Color.orange)
                    Text("\(Int(percent))%")
                        .font(.custom("ArialRoundedMTBold", size: 25))
                        .foregroundColor(Color("darkGreen"))
                }.onAppear(){
                    Task{
                        do {
                            
                            print("reload userData")
                            self.currentUserData = try await UserDataManager.shared.getUserData()
                            if self.currentUserData != nil {
                                let prevPoints = self.currentUserData?.points
                                let prevLevel = self.currentUserData?.level
                                self.currentUserData?.calculatePoints()
                                let currPoints = self.currentUserData?.points
                                let currLevel = self.currentUserData?.level
                                if (currPoints != prevPoints || prevLevel != currLevel){
                                    try await UserDataManager.shared.updateUserData(userData: self.currentUserData!)
                                }
                                print("points = \(self.currentUserData!.points)")
                                self.percent = Double( currentUserData?.points ?? 0) / 1000.0 * 100
                                print("percent = \(self.percent)")
                                
                                
                            } else {
                                percent = Double(0.0)
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                
                Text("Level \(Int(level))")
                    .font(.custom("ArialRoundedMTBold", size: 20))
                    .foregroundColor(Color("darkGreen"))
                    .padding(.top, 20)
                
            }.offset(x: 0, y: -325)
            Spacer()
            
            
            
        }.onAppear(){
            Task{
                do {
                    
                    print("load user data")
                    self.currentUserData = try await UserDataManager.shared.getUserData()
                    let level = self.currentUserData?.level ?? 1
                    print("level = \(level)")
                    self.levelUrl = getLevel(level: level)
                }
            }
        }
        
    }
    
    func getLevel(level: Int)-> String  //intended to use for switching views, but feature not available yet
    {
        switch (level){
        case 1:
            return "https://build.spline.design/DPtGR8v5tW0VWoK-9OHx/scene.splineswift"
        case 2:
            return "https://build.spline.design/tZcihgPczUt5yWQznyIJ/scene.splineswift"
        case 3:
            return "https://build.spline.design/Bo630vp1BIrFu5oEW1vQ/scene.splineswift"
        case 4:
            return "https://build.spline.design/GVQnwFLwdvjCMZBzGh5Z/scene.splineswift"
        case 5:
            return "https://build.spline.design/kp8IaUiCNJlt4zvnP7p1/scene.splineswift"
        case 6:
            return "https://build.spline.design/8Mz4FKxtGckoqVA-3TwL/scene.splineswift"
        case 7:
            return "https://build.spline.design/hed1XKgY0Cpfpm-3wiBq/scene.splineswift"
        case 8:
            return "https://build.spline.design/nfCrkTZDunW8vtNAeF4x/scene.splineswift"
        default:
            return "https://build.spline.design/nfCrkTZDunW8vtNAeF4x/scene.splineswift"
        }
    }
}




