import SwiftUI

struct RootView: View {
    @State private var showLevel1MenuView = false
    
    var body: some View {
        Button(action: {
            showLevel1MenuView = true
        }) {
            Text("Show Level 1 Menu")
        }
        .sheet(isPresented: $showLevel1MenuView) {
            Level1MenuView(showAlphabets: .constant(false), showPronunciation: .constant(false), showChallenge: .constant(false))
        }
    }
}

struct Level1MenuView: View {
    @Binding var showAlphabets: Bool
    @Binding var showPronunciation: Bool
    @Binding var showChallenge: Bool
    
    @State private var isPronunciationButtonPressed = false
    @State private var isChallengeButtonPressed = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: Level1View(), isActive: $showAlphabets) {
                    Button(action: {
                        showAlphabets = true
                        showPronunciation = false
                        showChallenge = false
                    }) {
                        Text("Alphabets")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Button(action: {
                    isPronunciationButtonPressed = true
                }) {
                    Text("Vowels")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isPronunciationButtonPressed) {
                    Level1View2()
                }
                
                Button(action: {
                    isChallengeButtonPressed = true
                }) {
                    Text("Challenge")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isChallengeButtonPressed) {
                    Level1Challenge()
                }
                
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Back")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
            }
            .padding()
            .navigationBarTitle("Level 1 Menu")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
