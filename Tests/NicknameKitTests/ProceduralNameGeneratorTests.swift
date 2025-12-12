@testable import NicknameKit
import Testing

@Suite("ProceduralNameGenerator Tests")
struct ProceduralNameGeneratorTests {
    // MARK: - Basic Generation

    @Test("Generates non-empty names")
    func generatesNonEmptyNames() {
        var generator = ProceduralNameGenerator()
        let name = generator.generate(syllableCount: 3)
        #expect(!name.isEmpty)
    }

    @Test("Generated names are capitalized")
    func generatedNamesAreCapitalized() {
        var generator = ProceduralNameGenerator()
        for _ in 0 ..< 100 {
            let name = generator.generate(syllableCount: 3)
            #expect(name.first?.isUppercase == true)
        }
    }

    @Test("Generates names with specified syllable count")
    func generatesSyllablesInRange() {
        var generator = ProceduralNameGenerator(style: .simple)
        // Simple style: each syllable is consonant + vowel (2 chars minimum)
        let name = generator.generate(syllableCount: 2)
        #expect(name.count >= 4) // At least 2 syllables × 2 chars
    }

    // MARK: - Syllable Count Clamping

    @Test("Clamps syllable count to minimum 1")
    func clampsSyllableCountMinimum() {
        var generator = ProceduralNameGenerator()
        let name = generator.generate(syllableCount: 0)
        #expect(!name.isEmpty)
    }

    @Test("Clamps syllable count to maximum 10")
    func clampsSyllableCountMaximum() {
        var generator = ProceduralNameGenerator()
        let name = generator.generate(syllableCount: 100)
        // Should not crash, should produce a name
        #expect(!name.isEmpty)
    }

    // MARK: - Seed Reproducibility

    @Test("Same seed produces same sequence")
    func seedProducesConsistentSequence() {
        let seed: UInt64 = 12345

        var generator1 = ProceduralNameGenerator(seed: seed)
        var generator2 = ProceduralNameGenerator(seed: seed)

        for _ in 0 ..< 10 {
            let name1 = generator1.generate(syllableCount: 3)
            let name2 = generator2.generate(syllableCount: 3)
            #expect(name1 == name2)
        }
    }

    @Test("Different seeds produce different sequences")
    func differentSeedsProduceDifferentSequences() {
        var generator1 = ProceduralNameGenerator(seed: 12345)
        var generator2 = ProceduralNameGenerator(seed: 54321)

        let name1 = generator1.generate(syllableCount: 3)
        let name2 = generator2.generate(syllableCount: 3)

        // Very unlikely to be the same
        #expect(name1 != name2)
    }

    // MARK: - Batch Generation

    @Test("Generates multiple names")
    func generatesMultipleNames() {
        var generator = ProceduralNameGenerator()
        let names = generator.generate(count: 10, syllableCount: 3)
        #expect(names.count == 10)
        for name in names {
            #expect(!name.isEmpty)
        }
    }

    @Test("Handles zero count")
    func handlesZeroCount() {
        var generator = ProceduralNameGenerator()
        let names = generator.generate(count: 0)
        #expect(names.isEmpty)
    }

    @Test("Handles negative count")
    func handlesNegativeCount() {
        var generator = ProceduralNameGenerator()
        let names = generator.generate(count: -5)
        #expect(names.isEmpty)
    }

    // MARK: - Range-Based Syllables

    @Test("Generates with syllable range")
    func generatesWithSyllableRange() {
        var generator = ProceduralNameGenerator()
        for _ in 0 ..< 50 {
            let name = generator.generate(syllableCount: 2 ... 4)
            #expect(!name.isEmpty)
        }
    }

    // MARK: - Custom Patterns

    @Test("Works with custom consonants and vowels")
    func worksWithCustomPatterns() {
        var generator = ProceduralNameGenerator(
            consonants: ["k", "l", "m"],
            vowels: ["a", "o"]
        )
        let name = generator.generate(syllableCount: 2)
        #expect(!name.isEmpty)
    }

    @Test("Works with custom pattern struct")
    func worksWithCustomPatternStruct() {
        let pattern = SyllablePattern(
            consonants: ["t", "n", "s"],
            vowels: ["a", "i", "u"]
        )
        var generator = ProceduralNameGenerator(pattern: pattern)
        let name = generator.generate(syllableCount: 3)
        #expect(!name.isEmpty)
    }
}
