import SwiftUI
import Firebase

// Ensure you have a class AuthViewModel defined as per your app's requirements
//class AuthViewModel: ObservableObject {
//    @Published var currentViewShowing: String = "login"
//}

struct LanguageSelectionView: View {
    @Binding var selectedLanguage: String?
    @EnvironmentObject var appState: AppState
    @State private var isPresented = false
    
    let languages = ["Hindi", "Spanish", "German", "French"]
    let imageNames = ["india", "spain", "germany", "france"] // Make sure these images are in your Assets.xcassets
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.0), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)

        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            gradient.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Button("Logout") {
                    
                        logoutUser()
                    }
                    .position(x:280)
                    .foregroundColor(.red)
                    .padding(10)
                    //.background(Color.red)
                    .cornerRadius(8)
                    Spacer()
                }
                //.padding(.horizontal)
                Image("4") // Use the name of the image as it appears in your asset catalog
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200) // Set the frame height or adjust accordingly
                    .padding(.top,20)
                
                
                Text("Select your Voyage")
                    .font(.title)
                    .foregroundColor(.black)
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(150), spacing: 20), count: 2), spacing: 20) {
                    ForEach(Array(zip(languages, imageNames)), id: \.0) { (language, imageName) in
                        Button(action: {
                            selectedLanguage = language
                            handleLanguageSelection(language)
                        }) {
                            VStack {
                                Image(imageName) // Image from Assets
                                    .resizable()
                                    .scaledToFit()
                                    //.frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                Text(language)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                }
                
                Spacer()
            }
            .background(
                Image("DialectorBG") // Set the background image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
    
    private func handleLanguageSelection(_ language: String) {
        // Update this method to handle what happens when a language is selected.
        // For instance, navigating to a different screen or updating a state.
        if language == "Hindi" {
            appState.isShowingHindiMenu = true
        } else {
            // Handle other languages
            isPresented = true
        }
    }
    
    private func logoutUser() {
        do {
            try Auth.auth().signOut()
            appState.isUserLoggedIn = false
            authViewModel.currentViewShowing = "login"
        } catch let error as NSError {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

// Assuming NextScreenView is correctly implemented elsewhere in your code.
// ...

struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView(selectedLanguage: .constant(nil), authViewModel: AuthViewModel())
            .environmentObject(AppState())
    }
}

class AppState: ObservableObject {
    @Published var isUserLoggedIn = true
    @Published var isShowingHindiMenu = false
}
