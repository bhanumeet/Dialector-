# Dialector

**Dialector** is an engaging language-learning app designed to help users learn Hindi. Inspired by the journey of a sailor exploring different cultures, Dialector is designed to make language acquisition both immersive and fun. With its mascot, a friendly sailor, Dialector takes users through different levels, from learning basic vowels and alphabets to words and sentences, providing a holistic language-learning experience.

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Structure](#structure)
5. [Technologies Used](#technologies-used)
6. [Roadmap](#roadmap)
7. [Contributing](#contributing)
8. [License](#license)

---

## Features

- **Interactive Learning Levels**: Dialector offers three primary levels:
    - **Vowels and Alphabets**: Learn Hindi script basics with flashcards.
    - **Words**: Build vocabulary with image-based flashcards.
    - **Sentences**: Understand and practice sentence formation.
  
- **Sailor Mascot**: A unique mascot guides users through the app, adding a touch of character and adventure to the learning journey.

- **Flashcards**: Each level uses flashcards that present Hindi characters or words along with their English meanings, pronunciation, and an image of the object.

- **Practice Exercises**: Dialector includes interactive challenges:
    - **Word Guessing**: Image-based guessing game.
    - **Matching Game**: Pair Hindi words with English meanings.
    - **Fill-in-the-Blanks**: Complete sentences with missing words.

- **Data Management**: Designed to efficiently manage a large dataset of Hindi words and sentences.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone (https://github.com/bhanumeet/Dialector-.git)
   cd dialector
   ```

2. **Open in Xcode**:
   - Ensure you have the latest version of [Xcode](https://developer.apple.com/xcode/) installed.
   - Open `Dialector.xcodeproj` in Xcode.

3. **Install Dependencies**:
   Dialector relies on certain iOS libraries and APIs:
   - [SwiftUI](https://developer.apple.com/xcode/swiftui/)
   - Google Sign-In (for user authentication)

   To install dependencies, follow these steps:
   - **Swift Package Manager**: Add required packages by going to `File` > `Add Packages...` in Xcode.

4. **Configure Google Sign-In (Optional)**:
   - If implementing Google login, ensure you have set up Google Sign-In in your project.
   - Add your Google API Key and enable OAuth credentials in the `Info.plist` file.

5. **Build and Run the App**:
   - Select your target device or simulator, then click on **Run** to build and launch the app.

## Usage

Upon launching the app, users can start their language-learning journey with a selection of levels, presented in a navigation-based interface.

1. **Level 1 - Vowels and Alphabets**:
   - Begin with flashcards featuring Hindi vowels and alphabets. Each flashcard displays the Hindi character, its English pronunciation, and sound.

2. **Level 2 - Words**:
   - Move to word learning. Each word is paired with an image and pronunciation. These sets of 10 words are followed by a sentence that uses each word in context, reinforcing learning.

3. **Level 3 - Sentences**:
   - Learn to form sentences in Hindi through guided flashcards and sentence examples.

4. **Practice Challenges**:
   - At the end of each level, test your knowledge with interactive games.

## Structure

Dialector is structured for easy maintainability and expandability. Key files and folders include:

- `ContentView.swift`: The main app view with navigation to different levels.
- `Level1MenuView.swift`: Displays options for Level 1.
- `Level2Words.swift`: Contains the word flashcards, image-based word learning, and sentence formation for Level 2.
- `Level3Sentences.swift`: Houses sentence learning and fill-in-the-blank practice exercises.
- `DataModels/`: Contains data files (e.g., consonant-vowel combinations, word sets) to manage the app's large vocabulary.

## Technologies Used

- **Swift & SwiftUI**: The app is built using Swift and SwiftUI for a native iOS experience.
- **Google Sign-In**: Optional user authentication.
- **API Integration**: Uses an illustration API to fetch images for flashcards.
- **File Management**: Stores Hindi words and sentences in separate files to prevent hardcoding data, ensuring efficient data access.

## Roadmap

### Current Features
- Alphabet, word, and sentence learning levels.
- Flashcard-based interactive learning.
- Practice challenges for retention.

### Upcoming Features
- Add progress tracking and user levels.
- Expand to additional languages.
- Develop a quiz mode for advanced learning.

## Contributing

We welcome contributions! To contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`.
3. Make changes and commit them: `git commit -m 'Added feature'`.
4. Push your changes: `git push origin feature-name`.
5. Create a pull request.

Please make sure your code follows the project's coding guidelines.

## License

This project is licensed under the MIT License.
