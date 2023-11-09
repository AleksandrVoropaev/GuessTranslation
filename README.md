# GuessTranslation App

[![Swift Version](https://img.shields.io/badge/Swift-5.5-orange.svg)](https://swift.org/)
[![iOS Version](https://img.shields.io/badge/iOS-14+-blue.svg)](https://developer.apple.com/ios/)
[![Combine](https://img.shields.io/badge/Combine-Yes-green.svg)](https://developer.apple.com/documentation/combine)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Yes-purple.svg)](https://developer.apple.com/xcode/swiftui/)
[![MVVM](https://img.shields.io/badge/Architecture-MVVM-yellow.svg)](https://en.wikipedia.org/wiki/Model–view–viewmodel)

The GuessTranslation app is a language learning game where the user is presented with an English word and must choose whether a given Spanish word is the correct translation or not. The game progresses through word pairs, and the user's attempts are tracked.

## Table of Contents

- [Investments](#investments)
- [Time Distribution](#distribution)
- [Decisions Made](#decisions)
- [Decisions Due to Restricted Time](#restrictions)
- [Future Improvements](#future)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Screenshots](#screenshots)

## Investments
### How much time was invested
The total time invested in developing this project was approximately 8 hours.

## Time Distribution
### How was the time distributed (concept, model layer, view(s), game mechanics)
- Concept and Clarifications: 30 min
- Initial setup: 45 min
- Logic: 45 min
- UI: 30 min
- Timer and Animations research: 1 hour 30 min
- Tests: 2 hours 30 min
- Finalization: 30 min
- Documentation: 1 hour

## Decisions Made
### Decisions made to solve certain aspects of the game
- Used the MVVM design pattern for a clear separation of concerns.
- Implemented a GameModel to handle words related logic.
- ViewModel manages the timer and the score logic.
- Designed a simple UI with buttons for correct and incorrect translations.
- Utilized the Mockable protocol to load word pairs from a JSON file.
- Generated random word pairs for display with a 25% chance of a correct pair using 'arc4random()'.
- To introduce an attempt timer I used the Timer instance instead of notification on animation completion because of iOS 14 support.

## Decisions Due to Restricted Time
### Decisions made because of restricted time
- The implementation of the timer was brought to the final stage.

## Future Improvements
### What would be the first thing to improve or add if there had been more time
- Remove timer. Rise the minimum supported iOS version to 15 or make some workaround.
- Improved UI.
- Improved Animations. Enhance the animation by adding more dynamic and engaging transitions.
- Difficulty Levels. Introduce different difficulty levels with varying word complexities.
- Sound Effects. Include sound effects for a more immersive gaming experience.
- Add more languages.

## Getting Started

### Prerequisites

- Xcode 15.0.1 or later
- iOS 14+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/AleksandrVoropaev/GuessTranslation.git
```
2. Navigate to the project directory:
```bash
cd GuessTranslation
```
3. Open the Xcode project file:
```bash
open GuessTranslation.xcodeproj
```
4. In `GameViewModel.swift`, set the Constants to the ones you need.
5. Build and run the app on a simulator or device.

## Usage

1. Launching the App: The game starts immediately upon opening the app.
2. Gameplay: A user can choose if the Spanish word is the correct or incorrect translation.
3. Attempts: After each attempt, the game displays the next English/Spanish word pair.
4. Scoring: A counter keeps track of correct and incorrect attempts.
5. Round Timer: Users have 5 seconds to make an attempt; if not, it is counted as an incorrect attempt.
6. End Scenario: The game ends after three incorrect attempts or after 15 word pairs.
7. End Dialog: A dialog appears at the end of the game, indicating the final score. There you can start over.

## Testing

The game logic is covered with tests. You can find them in `GameViewModelTests.swift` and `GameModelTests.swift`.

## Screenshots

![Game Screen](/Screenshots/game_screen.png)

![Game Over Alert](/Screenshots/game_over_alert.png)
