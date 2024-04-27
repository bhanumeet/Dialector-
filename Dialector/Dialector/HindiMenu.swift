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
            ZStack {
                Image("DialectorBG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Button("Back") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            showLevel1Menu = true
                            showAlphabets = true
                            showPronunciation = true
                            showChallenge = true
                        }) {
                            Image("11")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showLevel1Menu) {
                            Level1MenuView(showAlphabets: $showAlphabets, showPronunciation: $showPronunciation, showChallenge: $showChallenge)
                        }
                        
                        NavigationLink(destination: Level2WordsView(), isActive: $showLevel2WordsView) {
                            Button(action: {
                                showLevel2WordsView = true
                            }) {
                                Image("12")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 300, maxHeight: .infinity)
                                    .padding()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: Level3SentencesView(), isActive: $showLevel3SentencesView) {
                            Button(action: {
                                showLevel3SentencesView = true
                            }) {
                                Image("13")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            //.navigationBarTitle("Hindi Learning Menu", displayMode: .inline)
        }
    }
}

struct HindiMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HindiMenuView().environmentObject(AppState())
    }
}
