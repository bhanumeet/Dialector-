import SwiftUI

// Hindi Word Model
//struct HindiWord: Identifiable {
//    let id = UUID()
//    let hindi: String
//    let english: String
//    let image: String // Image name stored in assets
//}

// Sample Data
let sampleWords = [
    HindiWord(hindi: "सेब", english: "Apple", image: "apple"),
                HindiWord(hindi: "बिल्ली", english: "Cat", image: "cat"),
                HindiWord(hindi: "पेड़", english: "Tree", image: "tree"),
                HindiWord(hindi: "पानी", english: "Water", image: "water"),
                HindiWord(hindi: "घर", english: "Home", image: "home"),
                HindiWord(hindi: "पहाड़", english: "Mountain", image: "mountain"),
                HindiWord(hindi: "नदी", english: "River", image: "river"),
                HindiWord(hindi: "सूरज", english: "Sun", image: "sun"),
                HindiWord(hindi: "चाँद", english: "Moon", image: "moon"),
                HindiWord(hindi: "कुत्ता", english: "Dog", image: "dog"),
                HindiWord(hindi: "गाड़ी", english: "Vehicle", image: "vehicle"),
                HindiWord(hindi: "किताब", english: "Book", image: "book"),
                HindiWord(hindi: "कुर्सी", english: "Chair", image: "chair"),
                HindiWord(hindi: "मेज", english: "Table", image: "table"),
                HindiWord(hindi: "फूल", english: "Flower", image: "flower"),
                HindiWord(hindi: "पेन", english: "Pen", image: "pen"),
                HindiWord(hindi: "कलम", english: "Pen", image: "pen"),
                HindiWord(hindi: "मोबाइल", english: "Mobile", image: "mobile"),
                HindiWord(hindi: "खिड़की", english: "Window", image: "window")
]




// Define the Hindi syllable structure
struct HindiSyllable: Identifiable {
    let id = UUID()
    let consonant: String
    let vowel: String
    let result: String
}

// Sample data for Hindi syllables with consonant "ग(ga)"
let sampleSyllables = [
    HindiSyllable(consonant: "ग(ga)", vowel: "ा(aa)", result: "गा(gaa)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ि(i)", result: "गि(gi)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ी(ii)", result: "गी(gii)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ु(u)", result: "गु(gu)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ू(uu)", result: "गू(guu)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "े(e)", result: "गे(ge)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ै(ai)", result: "गै(gai)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ो(o)", result: "गो(go)"),
    HindiSyllable(consonant: "ग(ga)", vowel: "ौ(au)", result: "गौ(gau)"),
    // ... Add the rest of your syllables here
]

struct Level2WordsView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            Image("water") // Background image for the entire view
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(sampleSyllables) { syllable in
                            SyllableCardView(syllable: syllable)
                        }
                    }
                    .padding()
                }

                NavigationLink(destination: Level2Challenge()) {
                    Text("Let's go Sailor!")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
        .navigationBarTitle("Combinations", displayMode: .inline)
    }
}

// Assume Level2ChallengeView is defined in Level2Challenge.swift
// Here is an example definition, replace with your actual view implementation


// Make sure you have a preview for Level2ChallengeView
struct Level2ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        Level2Challenge()
    }
}

// You can keep the Level2WordsView_Previews as before to preview Level2WordsView

struct SyllableCardView: View {
    var syllable: HindiSyllable

    var body: some View {
        VStack(spacing: 5) {
            Text("\(syllable.consonant) + \(syllable.vowel)")
                .font(.system(size: 18))
                .foregroundColor(.brown)
                .bold()
            
            Text(syllable.result)
                .font(.system(size: 32))
                .foregroundColor(.brown)
                .bold()
        }
        .frame(width: 110, height: 110)
        .background(Image("sand") // Background image for each card
            .resizable()
            .aspectRatio(contentMode: .fill))
        .cornerRadius(12)
        .shadow(color: .black, radius: 5, x: 0, y: 2)
        .padding(30)
    }
}


// Preview for the Level2WordsView
struct Level2WordsView_Previews: PreviewProvider {
    static var previews: some View {
        Level2WordsView()
    }
}


struct HindiLearningApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Level2WordsView()
            }
        }
    }
}






// Detail View for Flashcards
struct WordDetailView: View {
    var word: HindiWord
    @State private var showEnglish = false

    var body: some View {
        VStack {
            Image(word.image)
                .resizable()
                .scaledToFit()
                .padding()

            Text(showEnglish ? word.english : word.hindi)
                .font(.largeTitle)
                .padding()
                .onTapGesture {
                    withAnimation {
                        showEnglish.toggle()
                    }
                }
        }
        .navigationTitle("Flashcard")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Custom Navigation Bar Color Modifier
struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    var textColor: UIColor?

    init(backgroundColor: UIColor?, textColor: UIColor?) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: textColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor, textColor: UIColor) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
    }
}
