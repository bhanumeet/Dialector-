import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var isLoggedIn = false
    @State private var selectedLanguage: String? = nil

    var body: some View {
        AuthView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LanguageContentView: View {
    let selectedLanguage: String
    @State private var showAlphabets = false
    @State private var showPronunciation = false
    @State private var showChallenge = false
    @State private var showLevel2Menu = false
    @State private var showLevel3Menu = false

    var body: some View {
        VStack {
            if selectedLanguage == "HINDI" {
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

                NavigationLink(destination: Level3SentencesView(), isActive: $showLevel3Menu) {
                    Text("Level 3: Sentences and Conversations")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            } else {
                Text("This language section is under construction")
            }
        }
    }
}


