import SwiftUI
import Foundation

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text:
                            $viewModel.currentInput)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.darkGreen)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
    }
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user { Spacer()
                Text(message.content)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.darkGreen)
                    .cornerRadius(16)
                Image("chatbot2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 2)
                
                
            }
            if message.role == .assistant {
                VStack{
                    Spacer(minLength: 0)
                        .frame(height: getHeight(for: message))
                    Image("chatbot1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 2)
                    
                }
                
                
                Text(message.content)
                    .foregroundColor(.black)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(16)
                
            }
            
        }
    }
}

private func getHeight(for message: Message) -> CGFloat {
    let textHeight = (message.content as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 120, height: .infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).height
    return textHeight
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
