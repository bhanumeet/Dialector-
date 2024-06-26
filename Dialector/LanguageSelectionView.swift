import SwiftUI

struct LanguageSelectionView: View {
    @Binding var selectedLanguage: String?
    @State private var isPresented = false
    @State private var shouldShowLevel1Menu = false
    
    @State private var showAlphabets = false
    @State private var showPronunciation = false
    @State private var showChallenge = false
    
    let languages = ["HINDI", "SPANISH", "GERMAN", "FRENCH"]
    let flags = ["🇮🇳", "🇪🇸", "🇩🇪", "🇫🇷"]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Select Language")
                    .font(.title)
                    .foregroundColor(.purple)
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(150), spacing: 20), count: 2), spacing: 20) {
                    ForEach(languages.indices, id: \.self) { index in
                        Button(action: {
                            selectedLanguage = languages[index]
                            
                            if languages[index] == "HINDI" {
                                shouldShowLevel1Menu = true
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
            
            if shouldShowLevel1Menu {
                Level1MenuView(showAlphabets: $showAlphabets, showPronunciation: $showPronunciation, showChallenge: $showChallenge)
            }
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
        LanguageSelectionView(selectedLanguage: .constant(nil))
    }
}
