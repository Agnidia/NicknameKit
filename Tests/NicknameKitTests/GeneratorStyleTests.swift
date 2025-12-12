@testable import NicknameKit
import Testing

@Suite("GeneratorStyle Tests")
struct GeneratorStyleTests {
    // MARK: - Style Properties

    @Test("All styles have valid patterns")
    func allStylesHaveValidPatterns() {
        for style in GeneratorStyle.allCases {
            let pattern = style.pattern
            #expect(!pattern.consonants.isEmpty)
            #expect(!pattern.vowels.isEmpty)
            #expect(!pattern.startConsonants.isEmpty)
        }
    }

    @Test("All styles have valid syllable ranges")
    func allStylesHaveValidSyllableRanges() {
        for style in GeneratorStyle.allCases {
            let range = style.suggestedSyllables
            #expect(range.lowerBound >= 1)
            #expect(range.upperBound <= 10)
            #expect(range.lowerBound <= range.upperBound)
        }
    }

    // MARK: - Style Generation

    @Test("Fantasy style generates names")
    func fantasyStyleGenerates() {
        var generator = ProceduralNameGenerator(style: .fantasy)
        let name = generator.generate(syllableCount: 3)
        #expect(!name.isEmpty)
        #expect(name.first?.isUppercase == true)
    }

    @Test("Modern style generates names")
    func modernStyleGenerates() {
        var generator = ProceduralNameGenerator(style: .modern)
        let name = generator.generate(syllableCount: 2)
        #expect(!name.isEmpty)
        #expect(name.first?.isUppercase == true)
    }

    @Test("Alien style generates names")
    func alienStyleGenerates() {
        var generator = ProceduralNameGenerator(style: .alien)
        let name = generator.generate(syllableCount: 2)
        #expect(!name.isEmpty)
        #expect(name.first?.isUppercase == true)
    }

    @Test("Simple style generates names")
    func simpleStyleGenerates() {
        var generator = ProceduralNameGenerator(style: .simple)
        let name = generator.generate(syllableCount: 3)
        #expect(!name.isEmpty)
        #expect(name.first?.isUppercase == true)
    }

    // MARK: - Style Variety

    @Test("Different styles produce different results with same seed")
    func differentStylesProduceDifferentResults() {
        let seed: UInt64 = 99999

        var fantasyGen = ProceduralNameGenerator(style: .fantasy, seed: seed)
        var alienGen = ProceduralNameGenerator(style: .alien, seed: seed)

        let fantasyName = fantasyGen.generate(syllableCount: 3)
        let alienName = alienGen.generate(syllableCount: 3)

        // Different patterns should produce different names
        #expect(fantasyName != alienName)
    }

    // MARK: - CaseIterable

    @Test("GeneratorStyle has all expected cases")
    func hasAllExpectedCases() {
        let cases = GeneratorStyle.allCases
        #expect(cases.count == 4)
        #expect(cases.contains(.fantasy))
        #expect(cases.contains(.modern))
        #expect(cases.contains(.alien))
        #expect(cases.contains(.simple))
    }
}
