/// NicknameKit - Procedural Nickname Generation Library
///
/// A lightweight Swift package for generating pronounceable random nicknames
/// using syllable-based phonetic patterns.
///
/// ## Quick Start
/// ```swift
/// import NicknameKit
///
/// // Generate a single nickname
/// let name = NicknameKit.generate()
/// // "Torak", "Brindel", "Sephira"
///
/// // Generate with specific style
/// let alienName = NicknameKit.generate(style: .alien)
/// // "Zyx'thal", "K'raan"
///
/// // Generate multiple nicknames
/// let names = NicknameKit.generate(count: 5)
/// ```
///
/// ## Features
/// - Multiple predefined styles (fantasy, modern, alien, simple)
/// - Customizable consonant and vowel patterns
/// - Seed-based reproducible generation
/// - Thread-safe and Sendable-compliant
/// - Zero external dependencies
public enum NicknameKit {
    // MARK: - Convenience Generation

    /// Generates a single random name.
    ///
    /// - Parameters:
    ///   - syllables: Number of syllables (default: 3, range: 1-10)
    ///   - style: Generation style (default: `.fantasy`)
    /// - Returns: A capitalized, pronounceable name
    ///
    /// ## Example
    /// ```swift
    /// let name = NicknameKit.generate()
    /// let shortName = NicknameKit.generate(syllables: 2)
    /// let modernName = NicknameKit.generate(style: .modern)
    /// ```
    public static func generate(
        syllables: Int = 3,
        style: GeneratorStyle = .fantasy
    ) -> String {
        var generator = ProceduralNameGenerator(style: style)
        return generator.generate(syllableCount: syllables)
    }

    /// Generates multiple random names.
    ///
    /// - Parameters:
    ///   - count: Number of names to generate
    ///   - syllables: Number of syllables per name (default: 3)
    ///   - style: Generation style (default: `.fantasy`)
    /// - Returns: Array of unique names (best effort, not guaranteed)
    ///
    /// ## Example
    /// ```swift
    /// let names = NicknameKit.generate(count: 10)
    /// let shortNames = NicknameKit.generate(count: 5, syllables: 2)
    /// ```
    public static func generate(
        count: Int,
        syllables: Int = 3,
        style: GeneratorStyle = .fantasy
    ) -> [String] {
        var generator = ProceduralNameGenerator(style: style)
        return generator.generate(count: count, syllableCount: syllables)
    }

    /// Generates a name with random syllable count in the given range.
    ///
    /// - Parameters:
    ///   - range: Range of possible syllable counts
    ///   - style: Generation style (default: `.fantasy`)
    /// - Returns: A capitalized, pronounceable name
    ///
    /// ## Example
    /// ```swift
    /// let name = NicknameKit.generate(syllables: 2...4)
    /// ```
    public static func generate(
        syllables range: ClosedRange<Int>,
        style: GeneratorStyle = .fantasy
    ) -> String {
        var generator = ProceduralNameGenerator(style: style)
        return generator.generate(syllableCount: range)
    }

    // MARK: - Generator Factory

    /// Creates a configured generator for repeated use.
    ///
    /// Use this when generating many names to avoid repeated setup.
    ///
    /// - Parameters:
    ///   - style: Generation style (default: `.fantasy`)
    ///   - seed: Optional seed for reproducible sequences
    /// - Returns: A configured `ProceduralNameGenerator`
    ///
    /// ## Example
    /// ```swift
    /// var generator = NicknameKit.generator(style: .modern, seed: 12345)
    /// for _ in 0..<100 {
    ///     print(generator.generate())
    /// }
    /// ```
    public static func generator(
        style: GeneratorStyle = .fantasy,
        seed: UInt64? = nil
    ) -> ProceduralNameGenerator {
        ProceduralNameGenerator(style: style, seed: seed)
    }

    /// Creates a custom generator with specified patterns.
    ///
    /// - Parameters:
    ///   - consonants: Consonant sounds to use
    ///   - vowels: Vowel sounds to use
    ///   - seed: Optional seed for reproducible sequences
    /// - Returns: A configured `ProceduralNameGenerator`
    ///
    /// ## Example
    /// ```swift
    /// var generator = NicknameKit.generator(
    ///     consonants: ["k", "l", "m", "n", "r", "s"],
    ///     vowels: ["a", "e", "i", "o"]
    /// )
    /// ```
    public static func generator(
        consonants: [String],
        vowels: [String],
        seed: UInt64? = nil
    ) -> ProceduralNameGenerator {
        ProceduralNameGenerator(
            consonants: consonants,
            vowels: vowels,
            seed: seed
        )
    }
}
