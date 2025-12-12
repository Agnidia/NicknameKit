/// Predefined name generation styles.
///
/// Each style produces names with a distinct character and feel.
///
/// ## Example
/// ```swift
/// let name = NameKit.generate(style: .fantasy)
/// // Produces names like: Torak, Elindra, Mythral
/// ```
public enum GeneratorStyle: String, Sendable, CaseIterable {
    /// Classic fantasy names with epic, mystical feel.
    ///
    /// Examples: Torak, Elindra, Mythral, Bryndis
    case fantasy

    /// Modern-sounding nicknames, short and punchy.
    ///
    /// Examples: Brix, Nova, Zane, Kira
    case modern

    /// Exotic, otherworldly names with unusual sounds.
    ///
    /// Examples: Zyx'thal, K'raan, Qu'oth
    case alien

    /// Basic, highly pronounceable names.
    ///
    /// Examples: Maba, Suko, Tilo, Rana
    case simple

    /// Returns the syllable pattern for this style.
    public var pattern: SyllablePattern {
        switch self {
        case .fantasy: .fantasy
        case .modern: .modern
        case .alien: .alien
        case .simple: .simple
        }
    }

    /// Suggested syllable count range for this style.
    public var suggestedSyllables: ClosedRange<Int> {
        switch self {
        case .fantasy: 2 ... 4
        case .modern: 1 ... 3
        case .alien: 2 ... 3
        case .simple: 2 ... 3
        }
    }
}
