import SwiftUI


import SwiftUI

struct HindiMenuView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @State private var showLevel1Menu = false
    @State private var showLevel2WordsView = false
    @State private var showLevel3SentencesView = false
    
    @State private var showAlphabets = false
    @State private var showPronunciation = false
    @State private var showChallenge = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Button("Back to Language Selection") {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)

                
                NavigationLink(destination: Level1MenuView(showAlphabets: $showAlphabets, showPronunciation: $showPronunciation, showChallenge: $showChallenge), isActive: $showLevel1Menu) {
                    Button("Level 1: Alphabets and Vowels") {
                        showLevel1Menu = true
                        showAlphabets = true
                        showPronunciation = true
                        showChallenge = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }

                NavigationLink(destination: Level2WordsView(), isActive: $showLevel2WordsView) {
                    Button("Level 2: Words") {
                        showLevel2WordsView = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }

                NavigationLink(destination: Level3SentencesView(), isActive: $showLevel3SentencesView) {
                    Button("Level 3: Sentences and Conversations") {
                        showLevel3SentencesView = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("Hindi Learning Menu", displayMode: .inline)
            .padding()
        }
    }
}


struct HindiMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HindiMenuView().environmentObject(AppState())
    }
}
