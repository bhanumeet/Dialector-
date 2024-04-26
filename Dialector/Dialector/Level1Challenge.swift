import SwiftUI
import AVFoundation

struct Level1Challenge: View {
    let hindiLetters = ["क", "ख", "ग", "घ", "ङ", "च", "छ", "ज", "झ", "ञ", "ट", "ठ", "ड", "ढ", "ण", "त", "थ", "द", "ध", "न", "प", "फ", "ब", "भ", "म", "य", "र", "ल", "व", "श", "ष", "स", "ह", "क्ष", "त्र", "ज्ञ"]
    
    let pronunciations = [
        "क": "ka", "ख": "kha", "ग": "ga", "घ": "gha", "ङ": "nga", "च": "cha", "छ": "chha", "ज": "ja", "झ": "jha", "ञ": "nya", "ट": "ta", "ठ": "tha", "ड": "da", "ढ": "dha", "ण": "ṇa", "त": "ta", "थ": "tha", "द": "da", "ध": "dha", "न": "na", "प": "pa", "फ": "pha", "ब": "ba", "भ": "bha", "म": "ma", "य": "ya", "र": "ra", "ल": "la", "व": "va", "श": "sha", "ष": "ṣa", "स": "sa", "ह": "ha", "क्ष": "kṣa", "त्र": "tra", "ज्ञ": "gya"
    ]
    
    @State private var currentQuestionIndex = UserDefaults.standard.integer(forKey: "currentQuestionIndex")
    @State private var selectedOption: String? = nil
    @State private var isCorrectAnswer: Bool = false
    @State private var showAlert: Bool = false
    @State private var currentCorrectAnswer: String? = nil
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func checkAnswer() {
        guard let selectedOption = selectedOption else { return }
        let currentAnswer = pronunciations[hindiLetters[currentQuestionIndex]]!
        currentCorrectAnswer = currentAnswer
        isCorrectAnswer = selectedOption == currentAnswer
        
        showAlert = true
        
        if isCorrectAnswer {
            currentQuestionIndex += 1
            UserDefaults.standard.set(currentQuestionIndex, forKey: "currentQuestionIndex")
        }
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        UserDefaults.standard.set(currentQuestionIndex, forKey: "currentQuestionIndex")
        selectedOption = nil
        isCorrectAnswer = false
        showAlert = false
        currentCorrectAnswer = nil
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if currentQuestionIndex < hindiLetters.count {
                Text("Guess the pronunciation of: \(hindiLetters[currentQuestionIndex])")
                    .font(.title)
                
                Text("Questions Remaining: \(hindiLetters.count - currentQuestionIndex)")
                    .font(.subheadline)
                
                let correctAnswer = pronunciations[hindiLetters[currentQuestionIndex]]!
                let incorrectOptions = pronunciations.values.filter { $0 != correctAnswer }.shuffled().prefix(2)
                let options = [correctAnswer] + Array(incorrectOptions)
                let shuffledOptions = options.shuffled()
                
                ForEach(shuffledOptions, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                        let speechUtterance = AVSpeechUtterance(string: option)
                        speechSynthesizer.speak(speechUtterance)
                    }) {
                        Text(option)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Button(action: {
                    checkAnswer()
                }) {
                    Text("Submit")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(isCorrectAnswer ? "Correct" : "Incorrect"),
                          message: Text("The correct pronunciation is: \(currentCorrectAnswer ?? "")"),
                          dismissButton: .default(Text("Next")) {
                            selectedOption = nil
                            showAlert = false
                          })
                }
            } else {
                Text("Quiz completed!")
                    .font(.title)
                
                Button(action: {
                    resetQuiz()
                }) {
                    Text("Reset Quiz")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

struct Level1Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Level1Challenge()
    }
}
