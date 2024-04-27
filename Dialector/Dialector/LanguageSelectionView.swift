import SwiftUI
import Firebase



struct LanguageSelectionView: View {
    @Binding var selectedLanguage: String?
    @EnvironmentObject var appState: AppState
    @State private var isPresented = false

    let languages = ["HINDI", "SPANISH", "GERMAN", "FRENCH"]
    let flags = ["🇮🇳", "🇪🇸", "🇩🇪", "🇫🇷"]

    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button("Logout") {
                        logoutUser()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer()
                }
                .padding(.horizontal)

                Text("Select Language")
                    .font(.title)
                    .foregroundColor(.purple)

                Spacer()

                LazyVGrid(columns: Array(repeating: GridItem(.fixed(150), spacing: 20), count: 2), spacing: 20) {
                    ForEach(languages.indices, id: \.self) { index in
                        Button(action: {
                            selectedLanguage = languages[index]
                            if languages[index] == "HINDI" {
                                appState.isShowingHindiMenu = true
                            } else {
                                withAnimation(.spring()) {
                                    isPresented = true
                                }
                            }
                        }) {
                            VStack {
                                Text(flags[index])
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text(languages[index])
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: 150, height: 150)
                            .background(Color.purple)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        }
                        .scaleEffect(isPresented ? 0.9 : 1)
                        .animation(.spring())
                    }
                }
                Spacer()
            }
            .padding()

            if isPresented {
                NextScreenView()
                    .transition(.move(edge: .trailing))
            }
        }
    }

    private func logoutUser() {
        do {
            try Auth.auth().signOut()
            appState.isUserLoggedIn = false
            authViewModel.currentViewShowing = "login"
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct NextScreenView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)

            VStack {
                Text("Next Screen")
                    .font(.title)
                    .foregroundColor(.white)
                Button("Go Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
            }
        }
    }
}

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
