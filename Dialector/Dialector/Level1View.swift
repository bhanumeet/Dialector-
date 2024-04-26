import SwiftUI
import AVFoundation

struct Level1View: View {
    let alphabets = ["अ", "आ", "इ", "ई", "उ", "ऊ", "ऋ", "ए", "ऐ", "ओ", "औ"]
    let pronunciations = ["a", "aa", "i", "ee", "u", "oo", "ri", "e", "ai", "o", "au"]
    
    @State private var currentAlphabetIndex = 0
    @State private var offset: CGFloat = 0
    @State private var degree: Double = 0
    @State private var isSpeaking = false
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.purple)
                        .frame(height: 200)
                        .frame(width: 250)
                        .offset(x: offset)
                        .rotationEffect(.degrees(degree))
                    
                    VStack {
                        Text(alphabets[currentAlphabetIndex])
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                        
                        Text(pronunciations[currentAlphabetIndex])
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    let speechUtterance = AVSpeechUtterance(string: pronunciations[currentAlphabetIndex])
                    speechSynthesizer.speak(speechUtterance)
                    isSpeaking = true
                }) {
                    Text("Listen")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.linear(duration: 0.2)) {
                            offset = value.translation.width
                            degree = Double(value.translation.width / 20)
                        }
                    }
                    .onEnded { value in
                        withAnimation(.linear(duration: 0.2)) {
                            if value.translation.width < -100 {
                                currentAlphabetIndex = (currentAlphabetIndex + 1) % alphabets.count
                                offset = 0
                                degree = 0
                            } else if value.translation.width > 100 {
                                currentAlphabetIndex = (currentAlphabetIndex + alphabets.count - 1) % alphabets.count
                                offset = 0
                                degree = 0
                            } else {
                                offset = 0
                                degree = 0
                            }
                        }
                    }
            )
        }
    }
}
