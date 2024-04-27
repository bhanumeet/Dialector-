import SwiftUI

struct HindiWord: Identifiable, Hashable {
    let id = UUID()
    let hindi: String
    let english: String
    let image: String

    static func == (lhs: HindiWord, rhs: HindiWord) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Updated CardView to swipe away without following the finger
struct CardView<Content: View>: View {
    var content: Content
    var onSwipeCompletion: () -> Void  // Callback to handle swipe completion

    init(@ViewBuilder content: () -> Content, onSwipeCompletion: @escaping () -> Void) {
        self.content = content()
        self.onSwipeCompletion = onSwipeCompletion
    }

    var body: some View {
        content
            .frame(width: 300, height: 400)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if abs(value.translation.width) > 100 {
                            withAnimation {
                                onSwipeCompletion()
                            }
                        }
                    }
            )
    }
}

struct FlashCardView: View {
    @Binding var words: [HindiWord]
    @State private var isMatchGamePresented = false
    @Binding var currentIndex: Int
    @Binding var score: Int

    var body: some View {
        ZStack {
            Image("grass")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if isMatchGamePresented {
                MatchWordsView(
                    words: $words,
                    recentWords: Array(words[max(0, currentIndex-5)..<currentIndex]), // Pass only the last five words
                    score: $score,
                    showNextWords: showNextWords
                )
            } else {
                if currentIndex < words.count {
                    CardView(content: {
                        VStack {
                            Text(words[currentIndex].hindi)
                                .font(.largeTitle)
                            Spacer()
                            Text(words[currentIndex].english)
                                .font(.title)
                        }
                        .padding()
                    }, onSwipeCompletion: {
                        currentIndex += 1
                        if (currentIndex % 5 == 0 || currentIndex == words.count) && currentIndex > 0 {
                            isMatchGamePresented = true
                        }
                    })
                    .transition(.slide)
                } else {
                    Text("All words reviewed")
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }

    func showNextWords() {
        if currentIndex < words.count {
            words.shuffle()
            isMatchGamePresented = false
        } else {
            // Reset to first index if at the end of the list
            currentIndex = 0
            words.shuffle()
            isMatchGamePresented = false
        }
    }
}

struct MatchWordsView: View {
    @Binding var words: [HindiWord]
    var recentWords: [HindiWord]
    @Binding var score: Int
    @State private var selections = [HindiWord?]()
    @State private var allAnswersCorrect = true
    @State private var showingPopup = false
    @State private var showingSuccessPopup = false
    var showNextWords: () -> Void
    
    @State private var shuffledWords: [HindiWord] // To maintain a consistent order

    init(words: Binding<[HindiWord]>, recentWords: [HindiWord], score: Binding<Int>, showNextWords: @escaping () -> Void) {
        self._words = words
        self.recentWords = recentWords
        self._score = score
        self.showNextWords = showNextWords
        self._selections = State(initialValue: Array(repeating: nil, count: recentWords.count))
        self._shuffledWords = State(initialValue: recentWords.shuffled())
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Match Words")
                    .font(.title)
                if !allAnswersCorrect {
                    Text("Please match all words correctly to proceed.")
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
                HStack {
                    VStack(alignment: .center) {
                        Text("Hindi Words")
                            .font(.headline)
                        ForEach(recentWords.indices, id: \.self) { index in
                            Text(recentWords[index].hindi)
                                .font(.title)
                                .padding()
                                .frame(width: geometry.size.width * 0.3) // Set width to 30% of window width
                                .background(selections[index] == nil ? Color.green : (selections[index] == recentWords[index] ? Color.green : Color.red))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    VStack(alignment: .center) {
                        Text("English Meanings")
                            .font(.headline)
                        ForEach(shuffledWords, id: \.self) { word in
                            Text(word.english)
                                .font(.title)
                                .padding()
                                .frame(width: geometry.size.width * 0.3) // Set width to 30% of window width
                                .background(selections.contains(word) ? Color.red : Color.green)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    if let selectedIndex = selections.firstIndex(where: {$0 == word}) {
                                        selections[selectedIndex] = nil // Deselect if already selected
                                    } else if let firstNilIndex = selections.firstIndex(of: nil) {
                                        selections[firstNilIndex] = word // Select if not already selected
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .padding()
                Spacer()
                Button("Submit") {
                    let correctAnswers = checkAnswers()
                    score += correctAnswers
                    if correctAnswers == recentWords.count {
                        showingSuccessPopup = true // Show success popup
                    } else {
                        allAnswersCorrect = false
                        showingPopup = true // Show popup on incorrect match
                    }
                }
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $showingPopup) {
                    Alert(
                        title: Text("Don't Get Discouraged!"),
                        message: Text("Try again and match the pairs correctly."),
                        dismissButton: .default(Text("Try Again")) {
                            // Reset the selections to allow for another attempt
                            selections = Array(repeating: nil, count: recentWords.count)
                            shuffledWords.shuffle() // Shuffle the words for another try
                            allAnswersCorrect = true
                        }
                    )
                }
                .alert(isPresented: $showingSuccessPopup) {
                    Alert(
                        title: Text("Great Job!"),
                        message: Text("Let's move to the next words."),
                        dismissButton: .default(Text("Continue")) {
                            showNextWords() // Move to next words
                        }
                    )
                }
            }
        }
    }

    func checkAnswers() -> Int {
        var correctAnswers = 0
        for (index, word) in recentWords.enumerated() {
            if selections[index] == word {
                correctAnswers += 1
            }
        }
        return correctAnswers
    }
}


struct Level2Challenge: View {
    @State private var hindiWords: [HindiWord] = HindiWordsData.words
    @State private var currentIndex = 0
    @State private var score = 0

    var body: some View {
        FlashCardView(words: $hindiWords, currentIndex: $currentIndex, score: $score)
    }
}


struct Level2Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Level2Challenge()
    }
}


