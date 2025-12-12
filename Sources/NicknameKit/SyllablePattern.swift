/// Configuration for syllable-based name generation.
///
/// Defines the building blocks (consonants, vowels) used to construct names.
///
/// ## Example
/// ```swift
/// let pattern = SyllablePattern(
///     consonants: ["b", "c", "d", "f"],
///     vowels: ["a", "e", "i", "o"]
/// )
/// ```
public struct SyllablePattern: Sendable, Equatable {
    /// Consonants used in the middle of names.
    public let consonants: [String]

    /// Vowels used throughout names.
    public let vowels: [String]

    /// Consonants allowed at the start of names.
    /// If nil, uses `consonants`.
    public let startConsonants: [String]

    /// Consonants allowed at the end of names.
    /// If nil, no ending consonant is added.
    public let endConsonants: [String]?

    /// Whether to allow double vowels (e.g., "aa", "ee").
    public let allowDoubleVowels: Bool

    /// Whether to allow double consonants (e.g., "bb", "dd").
    public let allowDoubleConsonants: Bool

    /// Creates a new syllable pattern.
    ///
    /// - Parameters:
    ///   - consonants: Consonant sounds for middle positions
    ///   - vowels: Vowel sounds
    ///   - startConsonants: Consonants for name beginnings (defaults to `consonants`)
    ///   - endConsonants: Optional consonants for name endings
    ///   - allowDoubleVowels: Allow consecutive identical vowels
    ///   - allowDoubleConsonants: Allow consecutive identical consonants
    public init(
        consonants: [String],
        vowels: [String],
        startConsonants: [String]? = nil,
        endConsonants: [String]? = nil,
        allowDoubleVowels: Bool = false,
        allowDoubleConsonants: Bool = false
    ) {
        self.consonants = consonants.isEmpty ? Self.defaultConsonants : consonants
        self.vowels = vowels.isEmpty ? Self.defaultVowels : vowels
        self.startConsonants = startConsonants ?? self.consonants
        self.endConsonants = endConsonants
        self.allowDoubleVowels = allowDoubleVowels
        self.allowDoubleConsonants = allowDoubleConsonants
    }

    // MARK: - Default Values

    private static let defaultConsonants = [
        "b", "c", "d", "f", "g", "k", "l", "m", "n", "p", "r", "s", "t", "v", "z",
    ]

    private static let defaultVowels = ["a", "e", "i", "o", "u"]
}

// MARK: - Predefined Patterns

public extension SyllablePattern {
    /// Classic fantasy-style names (e.g., Torak, Elindra, Mythral).
    ///
    /// Features blended consonants and diphthongs for an epic feel.
    static let fantasy = SyllablePattern(
        consonants: [
            "b", "c", "d", "f", "g", "k", "l", "m", "n", "p", "r", "s", "t", "v", "z",
            "br", "cr", "dr", "gr", "tr", "st", "th", "sh", "ch",
        ],
        vowels: ["a", "e", "i", "o", "u", "ai", "ea", "ou", "ae", "ia"],
        startConsonants: [
            "b", "c", "d", "f", "g", "k", "l", "m", "n", "r", "s", "t", "v",
            "br", "cr", "dr", "gr", "tr", "th", "sh",
        ],
        endConsonants: ["k", "n", "r", "s", "th", "x"]
    )

    /// Modern-sounding nicknames (e.g., Brix, Nova, Zane).
    ///
    /// Shorter, punchier sounds suitable for usernames and handles.
    static let modern = SyllablePattern(
        consonants: [
            "b", "c", "d", "f", "g", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "x", "z",
        ],
        vowels: ["a", "e", "i", "o", "u", "y"],
        startConsonants: [
            "b", "br", "c", "d", "f", "g", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "z",
        ],
        endConsonants: ["x", "z", "n", "r", "s"]
    )

    /// Exotic, otherworldly names (e.g., Zyx'thal, K'raan, Qu'oth).
    ///
    /// Uses unusual consonants and apostrophes for alien feel.
    static let alien = SyllablePattern(
        consonants: ["k", "q", "x", "z", "th", "zh", "kh", "'"],
        vowels: ["a", "e", "i", "o", "u", "y", "aa", "uu"],
        startConsonants: ["k", "q", "x", "z", "th", "zh"],
        endConsonants: ["k", "x", "th", "'l", "'n"]
    )

    /// Basic pronounceable names (e.g., Maba, Suko, Tilo).
    ///
    /// Simple CV patterns for maximum readability.
    static let simple = SyllablePattern(
        consonants: ["b", "d", "g", "k", "l", "m", "n", "p", "r", "s", "t"],
        vowels: ["a", "e", "i", "o", "u"],
        startConsonants: nil,
        endConsonants: nil
    )
}
