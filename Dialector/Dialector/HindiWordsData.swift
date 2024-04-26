//
//  HindiWordsData.swift
//  Dialector
//
//  Created by Meet on 4/25/24.
//

import Foundation

struct HindiWordsData {
    static let words: [HindiWord] = [
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
        HindiWord(hindi: "कलम", english: "Pen", image: "pen"),
        HindiWord(hindi: "मोबाइल", english: "Mobile", image: "mobile"),
        HindiWord(hindi: "खिड़की", english: "Window", image: "window"),
        HindiWord(hindi: "जूते", english: "Shoes", image: "shoes"),
        HindiWord(hindi: "बस", english: "Bus", image: "bus"),
        HindiWord(hindi: "ट्रेन", english: "Train", image: "train"),
        HindiWord(hindi: "पतंग", english: "Kite", image: "kite"),
        HindiWord(hindi: "घड़ी", english: "Watch", image: "watch"),
        HindiWord(hindi: "चश्मा", english: "Glasses", image: "glasses"),
        HindiWord(hindi: "ताला", english: "Lock", image: "lock"),
        HindiWord(hindi: "बॉल", english: "Ball", image: "ball"),
        HindiWord(hindi: "टोपी", english: "Hat", image: "hat"),
        HindiWord(hindi: "बटन", english: "Button", image: "button"),
        HindiWord(hindi: "चाबी", english: "Key", image: "key")
    ]
}



struct HindiSentences {
    static let sentences: [HindiSentence] = [
        HindiSentence(
            hindi: "सेब के पेड़ के नीचे बिल्ली पानी पी रही है और घर की ओर देख रही है।",
            english: "The cat is drinking water under the apple tree and looking towards the house.",
            pronunciation: "Seb ke ped ke neeche billi paani pee rahi hai aur ghar ki or dekh rahi hai.",
            words: [HindiWordsData.words[0], HindiWordsData.words[1], HindiWordsData.words[3], HindiWordsData.words[4]]
        ),
        HindiSentence(
            hindi: "सूरज नदी के पास पहाड़ पर चमक रहा है और कुत्ता चाँद की ओर भौंक रहा है।",
            english: "The sun is shining on the mountain near the river and the dog is barking towards the moon.",
            pronunciation: "Sooraj nadi ke paas pahaad par chamak raha hai aur kutta chaand ki or bhaunk raha hai.",
            words: [HindiWordsData.words[6], HindiWordsData.words[5], HindiWordsData.words[7], HindiWordsData.words[8], HindiWordsData.words[9]]
        ),
        HindiSentence(
            hindi: "मेज पर किताब और कलम है, और बगल में फूलों से भरी कुर्सी है।",
            english: "There is a book and a pen on the table, and next to it is a chair filled with flowers.",
            pronunciation: "Mez par kitaab aur kalam hai, aur bagal mein phoolon se bhari kursi hai.",
            words: [HindiWordsData.words[12], HindiWordsData.words[11], HindiWordsData.words[14], HindiWordsData.words[13], HindiWordsData.words[15]]
        ),
        HindiSentence(
                    hindi: "मोबाइल खिड़की के पास पड़ा है, जूते रखे हैं, और बस का इंतज़ार हो रहा है।",
                    english: "The mobile is lying near the window, shoes are kept, and waiting for the bus.",
                    pronunciation: "Mobile khidki ke paas pada hai, jute rakhe hain, aur bus ka intezar ho raha hai.",
                    words: [HindiWordsData.words[17], HindiWordsData.words[18], HindiWordsData.words[19]]
        ),
        HindiSentence(
                    hindi: "ट्रेन स्टेशन से निकल रही है, पतंग आकाश में उड़ रही है, घड़ी का समय देखो और चश्मे का इस्तेमाल करो।",
                    english: "The train is leaving the station, the kite is flying in the sky, check the time on the watch and use the glasses.",
                    pronunciation: "Train station se nikal rahi hai, patang aakash mein ud rahi hai, ghadi ka samay dekho aur chashme ka istemal karo.",
                    words: [HindiWordsData.words[20], HindiWordsData.words[21], HindiWordsData.words[22], HindiWordsData.words[23]]
        )
        
        // Add more sentences as needed
    ]
}

// HindiSentence structure, representing a sentence in Hindi and English, its pronunciation, and words used.
struct HindiSentence: Identifiable {
    let id: UUID = UUID()               // Unique identifier for each sentence.
    let hindi: String                   // Sentence in Hindi.
    let english: String                 // English translation of the sentence.
    let pronunciation: String           // Pronunciation guide for the sentence.
    var words: [HindiWord]              // List of words involved in the sentence.
}
