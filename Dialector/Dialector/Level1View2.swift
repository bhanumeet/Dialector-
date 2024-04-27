import SwiftUI
import AVFoundation

struct Level1View2: View {
    let alphabets = ["क", "ख", "ग", "घ", "ङ", "च", "छ", "ज", "झ", "ञ", "ट", "ठ", "ड", "ढ", "ण", "त", "थ", "द", "ध", "न", "प", "फ", "ब", "भ", "म", "य", "र", "ल", "व", "श", "ष", "स", "ह", "क्ष", "त्र", "ज्ञ"]
    let pronunciations: [String: String] = [
        "क": "ka", "ख": "kha", "ग": "ga", "घ": "gha", "ङ": "nga", "च": "cha", "छ": "chha", "ज": "ja", "झ": "jha", "ञ": "nya", "ट": "ta", "ठ": "tha", "ड": "da", "ढ": "dha", "ण": "ṇa", "त": "ta", "थ": "tha", "द": "da", "ध": "dha", "न": "na", "प": "pa", "फ": "pha", "ब": "ba", "भ": "bha", "म": "ma", "य": "ya", "र": "ra", "ल": "la", "व": "va", "श": "sha", "ष": "ṣa", "स": "sa", "ह": "ha", "क्ष": "kṣa", "त्र": "tra", "ज्ञ": "gya"
    ]
    
    @State private var currentAlphabetIndex = 0
    @State private var offset: CGFloat = 0
    @State private var degree: Double = 0
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            Image("DialectorBG")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    Image("sand")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .cornerRadius(25)
                        .offset(x: offset)
                        .rotationEffect(.degrees(degree))
                    
                    VStack {
                        Text(alphabets[currentAlphabetIndex])
                            .font(.system(size: 100))
                            .foregroundColor(.brown)
                        
                        Text(pronunciations[alphabets[currentAlphabetIndex]] ?? "")
                            .font(.title)
                            .foregroundColor(.brown)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    let speechUtterance = AVSpeechUtterance(string: pronunciations[alphabets[currentAlphabetIndex]] ?? "")
                    speechSynthesizer.speak(speechUtterance)
                }) {
                    Text("Listen")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
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

struct Level1View2_Previews: PreviewProvider {
    static var previews: some View {
        Level1View2()
    }
}
