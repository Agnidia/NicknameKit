/// Protocol for name generation strategies.
///
/// Implement this protocol to create custom name generators
/// with different algorithms or data sources.
///
/// ## Example
/// ```swift
/// struct MarkovNameGenerator: NameGenerating {
///     func generate(syllableCount: Int) -> String {
///         // Custom Markov chain implementation
///     }
/// }
/// ```
public protocol NameGenerating: Sendable {
    /// Generates a single name with the specified number of syllables.
    ///
    /// - Parameter syllableCount: Target number of syllables (clamped to 1...10)
    /// - Returns: A generated name
    mutating func generate(syllableCount: Int) -> String
}

public extension NameGenerating {
    /// Generates a single name with the default syllable count.
    ///
    /// - Returns: A generated name with 3 syllables
    mutating func generate() -> String {
        generate(syllableCount: 3)
    }

    /// Generates multiple names.
    ///
    /// - Parameters:
    ///   - count: Number of names to generate
    ///   - syllableCount: Target syllables per name
    /// - Returns: Array of generated names
    mutating func generate(count: Int, syllableCount: Int = 3) -> [String] {
        (0 ..< max(0, count)).map { _ in generate(syllableCount: syllableCount) }
    }

    /// Generates a name with random syllable count in the given range.
    ///
    /// - Parameter range: Range of possible syllable counts
    /// - Returns: A generated name
    mutating func generate(syllableCount range: ClosedRange<Int>) -> String {
        let count = Int.random(in: range)
        return generate(syllableCount: count)
    }
}
