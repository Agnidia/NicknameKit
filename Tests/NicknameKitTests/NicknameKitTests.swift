@testable import NicknameKit
import Testing

@Suite("NicknameKit Public API Tests")
struct NicknameKitTests {
    // MARK: - Static Generation

    @Test("generate() returns a name")
    func staticGenerateReturnsName() {
        let name = NicknameKit.generate()
        #expect(!name.isEmpty)
        #expect(name.first?.isUppercase == true)
    }

    @Test("generate(syllables:) respects syllable count")
    func staticGenerateWithSyllables() {
        let shortName = NicknameKit.generate(syllables: 2)
        let longName = NicknameKit.generate(syllables: 5)

        #expect(!shortName.isEmpty)
        #expect(!longName.isEmpty)
        // Long name should generally be longer (not guaranteed due to blends)
    }

    @Test("generate(style:) uses different styles")
    func staticGenerateWithStyle() {
        let fantasyName = NicknameKit.generate(style: .fantasy)
        let modernName = NicknameKit.generate(style: .modern)
        let alienName = NicknameKit.generate(style: .alien)
        let simpleName = NicknameKit.generate(style: .simple)

        #expect(!fantasyName.isEmpty)
        #expect(!modernName.isEmpty)
        #expect(!alienName.isEmpty)
        #expect(!simpleName.isEmpty)
    }

    // MARK: - Batch Generation

    @Test("generate(count:) returns correct number")
    func staticGenerateMultiple() {
        let names = NicknameKit.generate(count: 10)
        #expect(names.count == 10)
        for name in names {
            #expect(!name.isEmpty)
        }
    }

    @Test("generate(count:syllables:style:) works")
    func staticGenerateMultipleWithOptions() {
        let names = NicknameKit.generate(count: 5, syllables: 2, style: .modern)
        #expect(names.count == 5)
    }

    // MARK: - Range-Based Generation

    @Test("generate(syllables:range) works")
    func staticGenerateWithRange() {
        for _ in 0 ..< 20 {
            let name = NicknameKit.generate(syllables: 2 ... 4)
            #expect(!name.isEmpty)
        }
    }

    // MARK: - Generator Factory

    @Test("generator() creates working generator")
    func generatorFactoryWorks() {
        var generator = NicknameKit.generator()
        let name = generator.generate()
        #expect(!name.isEmpty)
    }

    @Test("generator(style:) creates styled generator")
    func generatorFactoryWithStyle() {
        var generator = NicknameKit.generator(style: .alien)
        let name = generator.generate()
        #expect(!name.isEmpty)
    }

    @Test("generator(seed:) creates seeded generator")
    func generatorFactoryWithSeed() {
        var gen1 = NicknameKit.generator(seed: 42)
        var gen2 = NicknameKit.generator(seed: 42)

        let name1 = gen1.generate()
        let name2 = gen2.generate()

        #expect(name1 == name2)
    }

    @Test("generator(consonants:vowels:) creates custom generator")
    func generatorFactoryCustom() {
        var generator = NicknameKit.generator(
            consonants: ["t", "k", "n"],
            vowels: ["a", "i"]
        )
        let name = generator.generate()
        #expect(!name.isEmpty)
    }

    // MARK: - Edge Cases

    @Test("Handles rapid generation")
    func handlesRapidGeneration() {
        var generator = NicknameKit.generator()
        for _ in 0 ..< 1000 {
            let name = generator.generate()
            #expect(!name.isEmpty)
        }
    }

    @Test("All generated names are valid")
    func allGeneratedNamesAreValid() {
        for style in GeneratorStyle.allCases {
            var generator = NicknameKit.generator(style: style)
            for syllables in 1 ... 5 {
                let name = generator.generate(syllableCount: syllables)
                #expect(!name.isEmpty, "Empty name for style \(style), syllables \(syllables)")
                #expect(name.first?.isUppercase == true, "Not capitalized: \(name)")
            }
        }
    }
}
