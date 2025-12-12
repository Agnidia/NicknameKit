/// Protocol for abstracting random number generation.
///
/// Allows deterministic testing and seed-based reproducibility.
protocol RandomSource: Sendable {
    mutating func nextUInt64() -> UInt64
}

extension RandomSource {
    /// Returns a random element from a non-empty array.
    mutating func randomElement<T>(from array: [T]) -> T {
        precondition(!array.isEmpty, "Cannot select random element from empty array")
        let index = Int(nextUInt64() % UInt64(array.count))
        return array[index]
    }

    /// Returns a random integer in the given range.
    mutating func randomInt(in range: ClosedRange<Int>) -> Int {
        let span = UInt64(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(nextUInt64() % span)
    }
}

/// Seeded random number generator using xorshift64 algorithm.
///
/// Provides deterministic sequences for reproducible name generation.
struct SeededRandom: RandomSource, Sendable {
    private var state: UInt64

    init(seed: UInt64) {
        // Ensure non-zero state (xorshift requires this)
        state = seed == 0 ? 1 : seed
    }

    mutating func nextUInt64() -> UInt64 {
        // xorshift64 algorithm - fast with good statistical properties
        state ^= state << 13
        state ^= state >> 7
        state ^= state << 17
        return state
    }
}

/// System random number generator wrapper.
///
/// Uses Swift's built-in random for non-deterministic generation.
struct SystemRandom: RandomSource, Sendable {
    init() {}

    mutating func nextUInt64() -> UInt64 {
        UInt64.random(in: .min ... .max)
    }
}
