import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Text("Welcome! My name is Lily! Sign in to get started!")
                .font(.custom("ArialRoundedMTBold", size: 40))
            //.padding(.horizontal, 30)
                .foregroundColor(Color("darkGreen"))
                .padding(.top, 20)
            Image("crispebacon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 175, height: 275)
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background (Color.darkGreen)
                    .cornerRadius(10)
            }
            
            
            Spacer()
        }
        .padding()
    }
}
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
