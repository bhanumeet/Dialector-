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

// Hindi Syllable Model
struct HindiSyllable: Identifiable {
    let id = UUID()
    let consonant: String
    let vowel: String
    let result: String
}

// Main View for Level 2
struct Level2WordsView: View {
    // Components for syllable formation with the consonant 'ग'
    let syllables = [
        HindiSyllable(consonant: "ग(ga)", vowel: "ा(aa)", result: "गा(gaa)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ि(i)", result: "गि(gi)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ी(ee)", result: "गी(gee)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ु(u)", result: "गु(gu)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ू(oo)", result: "गू(goo)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "े(ay)", result: "गे(gay)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ै(ei)", result: "गै(gai)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ो(o)", result: "गो(go)"),
        HindiSyllable(consonant: "ग(ga)", vowel: "ौ(au)", result: "गौ(gau)")
    ]

    var body: some View {
        NavigationView {
            List(syllables) { syllable in
                HStack {
                    Text("\(syllable.consonant) + \(syllable.vowel)")
                    Text("=")
                    Text(syllable.result)
                        .fontWeight(.bold)
                }
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.purple.opacity(0.1)) // Light purple background for each cell
                .cornerRadius(8)
                .padding(.vertical, 4)
            }
            .navigationTitle("Hindi Syllables Formation")
            .toolbar {
                NavigationLink(destination: Level2Challenge()) {
                    Text("Challenges")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor.systemPurple, textColor: UIColor.white) // Custom navigation bar colors
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

// Preview Provider
struct Level2WordsView_Previews: PreviewProvider {
    static var previews: some View {
        Level2WordsView()
    }
}
