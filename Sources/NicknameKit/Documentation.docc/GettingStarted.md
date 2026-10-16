# Getting Started with NicknameKit

Learn how to generate random nicknames in your Swift application.

## Overview

NicknameKit provides a simple API for generating pronounceable random nicknames. Whether you need fantasy character names, modern usernames, or alien-sounding identifiers, NicknameKit has you covered.

## Installation

Add NicknameKit to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/Agnidia/NicknameKit.git", from: "1.0.0")
]
```

Then add it to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: ["NicknameKit"]
)
```

## Quick Start

### Generate a Single Nickname

The simplest way to generate a nickname is using the static `generate()` method:

```swift
import NicknameKit

let name = NicknameKit.generate()
// "Brindel"
```

### Choose a Style

NicknameKit includes four predefined styles:

```swift
// Epic fantasy nicknames
let fantasy = NicknameKit.generate(style: .fantasy)
// "Torak", "Elindra", "Mythral"

// Short, punchy nicknames
let modern = NicknameKit.generate(style: .modern)
// "Brix", "Nova", "Zane"

// Exotic, otherworldly nicknames
let alien = NicknameKit.generate(style: .alien)
// "K'zyx", "Zythul"

// Simple, highly readable nicknames
let simple = NicknameKit.generate(style: .simple)
// "Maba", "Suko", "Tilo"
```

### Control Nickname Length

Adjust the number of syllables to control nickname length:

```swift
// Short nicknames (2 syllables)
let short = NicknameKit.generate(syllables: 2)
// "Torak"

// Long nicknames (5 syllables)
let long = NicknameKit.generate(syllables: 5)
// "Elindraseth"

// Random length
let varied = NicknameKit.generate(syllables: 2...4)
```

### Generate Multiple Nicknames

Create batches of nicknames at once:

```swift
let names = NicknameKit.generate(count: 10)
// ["Brindel", "Torak", "Sephira", ...]

let shortNames = NicknameKit.generate(count: 5, syllables: 2, style: .modern)
```

## Reproducible Generation

For consistent results, use a seeded generator:

```swift
var generator = NicknameKit.generator(seed: 12345)

let name1 = generator.generate()  // Always "Brindel"
let name2 = generator.generate()  // Always "Torak"
```

This is useful for:
- Testing
- Procedural content generation
- Reproducible game worlds

## Custom Patterns

Create nicknames with your own phonetic patterns:

```swift
var generator = NicknameKit.generator(
    consonants: ["k", "l", "m", "n", "r", "s"],
    vowels: ["a", "i", "o"]
)

let name = generator.generate()
// Uses only your specified sounds
```

## Reusable Generators

For generating many nicknames, create a reusable generator:

```swift
var generator = NicknameKit.generator(style: .fantasy)

for _ in 0..<100 {
    let name = generator.generate()
    print(name)
}
```

## Thread Safety

All NicknameKit types are `Sendable` and safe to use across threads:

```swift
// Safe to use in concurrent contexts
await withTaskGroup(of: String.self) { group in
    for _ in 0..<10 {
        group.addTask {
            NicknameKit.generate()
        }
    }
    // ...
}
```

## Next Steps

- Explore ``GeneratorStyle`` for all available styles
- Create custom patterns with ``SyllablePattern``
- Learn about the ``NameGenerating`` protocol for custom generators
