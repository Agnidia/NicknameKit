/// Procedural name generator using syllable-based patterns.
///
/// Generates pronounceable names by alternating consonants and vowels
/// according to configurable patterns.
///
/// ## Basic Usage
/// ```swift
/// var generator = ProceduralNameGenerator()
/// let name = generator.generate(syllableCount: 3)
/// // Produces names like: Torak, Brindel, Sephira
/// ```
///
/// ## Custom Patterns
/// ```swift
/// var generator = ProceduralNameGenerator(
///     consonants: ["k", "l", "m", "n"],
///     vowels: ["a", "i", "o"]
/// )
/// ```
///
/// ## Reproducible Sequences
/// ```swift
/// var generator = ProceduralNameGenerator(seed: 12345)
/// // Always produces the same sequence of names
/// ```
public struct ProceduralNameGenerator: NameGenerating, Sendable {
    private let pattern: SyllablePattern
    private var random: any RandomSource

    // MARK: - Initialization

    /// Creates a generator with a predefined style.
    ///
    /// - Parameters:
    ///   - style: The generation style (default: `.fantasy`)
    ///   - seed: Optional seed for reproducible sequences
    public init(style: GeneratorStyle = .fantasy, seed: UInt64? = nil) {
        pattern = style.pattern
        random = seed.map { SeededRandom(seed: $0) } ?? SystemRandom() as any RandomSource
    }

    /// Creates a generator with a custom syllable pattern.
    ///
    /// - Parameters:
    ///   - pattern: Custom syllable configuration
    ///   - seed: Optional seed for reproducible sequences
    public init(pattern: SyllablePattern, seed: UInt64? = nil) {
        self.pattern = pattern
        random = seed.map { SeededRandom(seed: $0) } ?? SystemRandom() as any RandomSource
    }

    /// Creates a generator with custom consonants and vowels.
    ///
    /// - Parameters:
    ///   - consonants: Consonant sounds to use
    ///   - vowels: Vowel sounds to use
    ///   - startConsonants: Optional consonants for name beginnings
    ///   - endConsonants: Optional consonants for name endings
    ///   - seed: Optional seed for reproducible sequences
    public init(
        consonants: [String],
        vowels: [String],
        startConsonants: [String]? = nil,
        endConsonants: [String]? = nil,
        seed: UInt64? = nil
    ) {
        pattern = SyllablePattern(
            consonants: consonants,
            vowels: vowels,
            startConsonants: startConsonants,
            endConsonants: endConsonants
        )
        random = seed.map { SeededRandom(seed: $0) } ?? SystemRandom() as any RandomSource
    }

    // MARK: - NameGenerating

    /// Generates a single name with the specified number of syllables.
    ///
    /// - Parameter syllableCount: Target number of syllables (clamped to 1...10)
    /// - Returns: A capitalized, pronounceable name
    public mutating func generate(syllableCount: Int) -> String {
        let count = max(1, min(syllableCount, 10))
        var parts: [String] = []

        for syllableIndex in 0 ..< count {
            let isFirst = syllableIndex == 0
            let isLast = syllableIndex == count - 1

            // Select consonant
            let consonant: String
            if isFirst {
                consonant = random.randomElement(from: pattern.startConsonants)
            } else {
                consonant = random.randomElement(from: pattern.consonants)
            }
            parts.append(consonant)

            // Select vowel
            let vowel = random.randomElement(from: pattern.vowels)
            parts.append(vowel)

            // Optionally add ending consonant
            if isLast, let endConsonants = pattern.endConsonants, !endConsonants.isEmpty {
                // 50% chance to add ending consonant
                if random.nextUInt64() % 2 == 0 {
                    let endConsonant = random.randomElement(from: endConsonants)
                    parts.append(endConsonant)
                }
            }
        }

        let rawName = parts.joined()
        return PostProcessor.clean(rawName, pattern: pattern)
    }
}
