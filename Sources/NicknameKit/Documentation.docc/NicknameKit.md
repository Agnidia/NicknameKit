# ``NicknameKit``

Generate pronounceable random nicknames using syllable-based phonetic patterns.

## Overview

NicknameKit is a lightweight Swift package for procedural nickname generation. It creates pronounceable nicknames by combining consonants and vowels in patterns that sound natural across multiple styles.

```swift
import NicknameKit

// Generate a fantasy-style nickname
let name = NicknameKit.generate()
// "Brindel", "Torak", "Sephira"

// Generate an alien-style nickname
let alienName = NicknameKit.generate(style: .alien)
// "K'zyx", "Zythul"
```

## Features

- **Multiple Styles**: Fantasy, modern, alien, and simple patterns
- **Customizable**: Define your own consonants and vowels
- **Reproducible**: Seed-based generation for consistent results
- **Thread-Safe**: Full Swift 6 concurrency support
- **Zero Dependencies**: Pure Swift implementation

## Topics

### Essentials

- <doc:GettingStarted>
- ``NicknameKit``

### Generation

- ``ProceduralNameGenerator``
- ``NameGenerating``

### Configuration

- ``GeneratorStyle``
- ``SyllablePattern``
