import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var selectedLanguage: String? = nil
    @State private var showAlphabets = false
    @State private var showPronunciation = false
    @State private var showChallenge = false
    @State private var showLevel2Menu = false
    @State private var showLevel3Menu = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                if let selectedLanguage = selectedLanguage {
                    if selectedLanguage == "HINDI" {
                        VStack {
                            NavigationLink(destination: Level1MenuView(showAlphabets: $showAlphabets, showPronunciation: $showPronunciation, showChallenge: $showChallenge)) {
                                Text("Level 1: Alphabets and Vowels")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }

                            NavigationLink(destination: Level2WordsView()) {
                                Text("Level 2: Words")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        Text("This is under construction")
                    }
                } else {
                    LanguageSelectionView(selectedLanguage: $selectedLanguage)
                }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
