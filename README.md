# NicknameKit

A lightweight Swift package for generating pronounceable random nicknames using syllable-based phonetic patterns.

## Features

- **Multiple Styles**: Fantasy, modern, alien, and simple nickname patterns
- **Customizable**: Define your own consonants and vowels
- **Reproducible**: Seed-based generation for consistent results
- **Thread-Safe**: Full Swift 6 concurrency support
- **Cross-Platform**: macOS, iOS, tvOS, watchOS, visionOS, Linux
- **Zero Dependencies**: Pure Swift implementation

## Installation

Add NicknameKit to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/IGRSoft/NicknameKit.git", from: "1.0.0")
]
```

## Quick Start

```swift
import NicknameKit

// Generate a single nickname
let name = NicknameKit.generate()
// "Brindel", "Torak", "Sephira"

// Generate with a specific style
let alienName = NicknameKit.generate(style: .alien)
// "K'zyx", "Zythul"

// Generate multiple nicknames
let names = NicknameKit.generate(count: 10)
```

## Generation Styles

| Style | Description | Examples |
|-------|-------------|----------|
| `.fantasy` | Epic, mystical nicknames | Torak, Elindra, Mythral |
| `.modern` | Short, punchy nicknames | Brix, Nova, Zane |
| `.alien` | Exotic, otherworldly | K'raan, Zyx'thal |
| `.simple` | Basic, highly readable | Maba, Suko, Tilo |

## Advanced Usage

### Syllable Control

```swift
// Short nicknames (1-2 syllables)
let short = NicknameKit.generate(syllables: 2)

// Long nicknames (4-5 syllables)
let long = NicknameKit.generate(syllables: 5)

// Random syllable count
let varied = NicknameKit.generate(syllables: 2...4)
```

### Reproducible Generation

```swift
// Same seed always produces the same sequence
var generator = NicknameKit.generator(seed: 12345)
let name1 = generator.generate()  // Always "Brindel"
let name2 = generator.generate()  // Always "Torak"
```

### Custom Patterns

```swift
// Create a generator with custom sounds
var generator = NicknameKit.generator(
    consonants: ["k", "l", "m", "n", "r", "s"],
    vowels: ["a", "i", "o"]
)

let name = generator.generate()
// Uses only your specified sounds
```

### Batch Generation

```swift
// Generate many nicknames at once
let names = NicknameKit.generate(count: 100, syllables: 3, style: .fantasy)
```

## API Reference

### NicknameKit (Static Methods)

```swift
// Single nickname generation
NicknameKit.generate(syllables: Int = 3, style: GeneratorStyle = .fantasy) -> String

// Batch generation
NicknameKit.generate(count: Int, syllables: Int = 3, style: GeneratorStyle = .fantasy) -> [String]

// Range-based syllables
NicknameKit.generate(syllables: ClosedRange<Int>, style: GeneratorStyle = .fantasy) -> String

// Create a reusable generator
NicknameKit.generator(style: GeneratorStyle = .fantasy, seed: UInt64? = nil) -> ProceduralNameGenerator
```

### ProceduralNameGenerator

```swift
// Generate a single nickname
mutating func generate(syllableCount: Int = 3) -> String

// Generate multiple nicknames
mutating func generate(count: Int, syllableCount: Int = 3) -> [String]
```

### GeneratorStyle

```swift
enum GeneratorStyle: String, Sendable, CaseIterable {
    case fantasy    // Epic fantasy nicknames
    case modern     // Modern nicknames
    case alien      // Exotic nicknames
    case simple     // Basic readable nicknames
}
```

## Requirements

- Swift 6.0+
- macOS 12+ / iOS 15+ / tvOS 15+ / watchOS 8+ / visionOS 1+

## License

MIT License
