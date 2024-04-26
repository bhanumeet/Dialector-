//  Level3Sentences.swift
//  Dialector
//
//  Created by Meet on 4/25/24.
//

import Foundation
import SwiftUI

// MARK: - Data Models


// MARK: - Sentence Manager
class SentenceManager {
    static let shared = SentenceManager()
    private var sentences: [HindiSentence] = HindiSentences.sentences
    private var index = 0
    
    init() {
        sentences.shuffle()  // Shuffle initially to start at a random point in a non-repeating manner
    }
    
    func getNextSentence() -> HindiSentence? {
        if sentences.isEmpty { return nil }
        
        let sentence = sentences[index]
        index = (index + 1) % sentences.count  // Cycle through the sentences
        return sentence
    }
}


// MARK: - View Model
class SentenceViewModel: ObservableObject {
    @Published var currentSentence: HindiSentence?
    @Published var question: String = ""
    @Published var options: [String] = []
    @Published var correctAnswer: String = ""
    @Published var isQuestionActive = false // Controls whether we are showing a question or the sentence
    
    private var currentWordIndex = 0
    
    init() {
        loadNewSentence()
    }
    
    func loadNewSentence() {
        if let sentence = SentenceManager.shared.getNextSentence() {
            currentSentence = sentence
            currentWordIndex = 0
            isQuestionActive = false  // Reset to show the new sentence card first
        }
    }
    
    func startQuestions() {
        isQuestionActive = true
        prepareQuestion()
    }
    
    func prepareQuestion() {
        guard let sentence = currentSentence, sentence.words.indices.contains(currentWordIndex) else {
            loadNewSentence()
            return
        }
        let word = sentence.words[currentWordIndex]
        question = "Which of the following is '\(word.english.lowercased())'?"
        correctAnswer = word.hindi
        options = sentence.words.map { $0.hindi }.shuffled()
    }
    
    func checkAnswer(_ answer: String) {
        if answer == correctAnswer {
            currentWordIndex += 1
            if currentWordIndex >= currentSentence?.words.count ?? 0 {
                loadNewSentence()  // Load new sentence if all questions answered
            } else {
                prepareQuestion()  // Load next question for current sentence
            }
        }
    }
}

// MARK: - SwiftUI View
struct SentenceView: View {
    @StateObject private var viewModel = SentenceViewModel()
    @State private var offset = CGSize.zero  // To track the gesture's translation

    var body: some View {
        VStack {
            if let sentence = viewModel.currentSentence {
                if !viewModel.isQuestionActive {
                    // Flashcard view
                    VStack {
                        Text(sentence.hindi)
                            .font(.title)
                            .padding()
                        Text(sentence.english)
                            .foregroundColor(.gray)
                            .padding()
                        Text(sentence.pronunciation)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
                    .offset(x: offset.width, y: 0)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { _ in
                                if abs(self.offset.width) > 100 {
                                    // Trigger to start questions
                                    viewModel.startQuestions()
                                }
                                self.offset = .zero  // Reset the position
                            }
                    )
                    .animation(.spring(), value: offset)
                } else {
                    // Question view
                    VStack {
                        Text(viewModel.question)
                            .padding()
                        ForEach(viewModel.options, id: \.self) { option in
                            Button(option) {
                                viewModel.checkAnswer(option)
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
            } else {
                Text("Loading new sentence...").padding()
            }
        }
        .onAppear {
            viewModel.loadNewSentence()
        }
    }
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView()
    }
}
struct Level3SentencesView: View {
    var body: some View {
        SentenceView()
    }
}

// This is a supporting structure to run the SwiftUI preview in Xcode
struct Level3SentencesView_Previews: PreviewProvider {
    static var previews: some View {
        Level3SentencesView()
    }
}
