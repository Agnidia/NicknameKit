@testable import NicknameKit
import Testing

@Suite("PostProcessor Tests")
struct PostProcessorTests {
    private let pattern = SyllablePattern.simple

    // MARK: - Capitalization

    @Test("Capitalizes first letter")
    func capitalizesFirstLetter() {
        let result = PostProcessor.clean("mabari", pattern: pattern)
        #expect(result == "Mabari")
    }

    @Test("Handles already capitalized input")
    func handlesAlreadyCapitalized() {
        let result = PostProcessor.clean("MABARI", pattern: pattern)
        #expect(result == "Mabari")
    }

    // MARK: - Triple Consonant Removal

    @Test("Removes third consecutive consonant")
    func removesTripleConsonants() {
        // "abrke" has b-r-k = 3 consecutive consonants, e is vowel
        let result = PostProcessor.clean("abrke", pattern: pattern)
        // Keeps first two consonants (br), removes third (k), keeps vowel (e)
        #expect(result == "Abre")
    }

    @Test("Removes excess consecutive consonants")
    func removesExcessConsonants() {
        // "abstrae" has b-s-t-r = 4 consonants in a row before vowel
        let result = PostProcessor.clean("abstrae", pattern: pattern)
        // Keeps first two (bs), removes excess (tr), keeps rest
        #expect(result == "Absae")
    }

    @Test("Keeps double consonants")
    func keepsDoubleConsonants() {
        let result = PostProcessor.clean("abea", pattern: pattern)
        #expect(result == "Abea")
    }

    @Test("Keeps valid consonant clusters with vowels")
    func keepsValidConsonants() {
        let result = PostProcessor.clean("marta", pattern: pattern)
        // m-a-r-t-a: no triple consonants (separated by vowels)
        #expect(result == "Marta")
    }

    // MARK: - Triple Vowel Removal

    @Test("Removes third consecutive vowel")
    func removesTripleVowels() {
        // "baaab" has 3 a's in a row
        let result = PostProcessor.clean("baaab", pattern: pattern)
        // Keeps first two a's, removes third
        #expect(result == "Baab")
    }

    @Test("Removes excess consecutive vowels")
    func removesExcessVowels() {
        // "boiaeb" has o-i-a-e = 4 consecutive vowels
        let result = PostProcessor.clean("boiaeb", pattern: pattern)
        // Keeps first two (oi), removes rest (ae)
        #expect(result == "Boib")
    }

    @Test("Keeps double vowels")
    func keepsDoubleVowels() {
        let result = PostProcessor.clean("baat", pattern: pattern)
        #expect(result == "Baat")
    }

    // MARK: - Awkward Combinations

    @Test("Fixes xq combination")
    func fixesXqCombination() {
        let result = PostProcessor.clean("axqe", pattern: pattern)
        #expect(!result.lowercased().contains("xq"))
    }

    @Test("Removes double apostrophes")
    func removesDoubleApostrophes() {
        let result = PostProcessor.clean("ka''ra", pattern: pattern)
        #expect(!result.contains("''"))
    }

    @Test("Removes leading apostrophe")
    func removesLeadingApostrophe() {
        let result = PostProcessor.clean("'kara", pattern: pattern)
        #expect(!result.hasPrefix("'"))
    }

    @Test("Removes trailing apostrophe")
    func removesTrailingApostrophe() {
        let result = PostProcessor.clean("kara'", pattern: pattern)
        #expect(!result.hasSuffix("'"))
    }

    // MARK: - Minimum Length

    @Test("Ensures minimum length")
    func ensuresMinimumLength() {
        let result = PostProcessor.clean("a", pattern: pattern)
        #expect(result.count >= 2)
    }

    @Test("Handles empty input")
    func handlesEmptyInput() {
        let result = PostProcessor.clean("", pattern: pattern)
        #expect(result.count >= 2)
    }

    // MARK: - Combined Rules

    @Test("Applies all rules together")
    func appliesAllRulesTogether() {
        let result = PostProcessor.clean("'abrkeeee'", pattern: pattern)

        // Should be capitalized
        #expect(result.first?.isUppercase == true)
        // Should not have triple consonants
        #expect(!hasTripleConsonants(result))
        // Should not have triple vowels
        #expect(!hasTripleVowels(result))
        // Should not have leading/trailing apostrophes
        #expect(!result.hasPrefix("'"))
        #expect(!result.hasSuffix("'"))
    }

    // MARK: - Generated Names Quality

    @Test("Generated names pass post-processing rules")
    func generatedNamesPassRules() {
        var generator = ProceduralNameGenerator()
        for _ in 0 ..< 100 {
            let name = generator.generate(syllableCount: 3)
            #expect(!hasTripleConsonants(name), "Name '\(name)' has triple consonants")
            #expect(!hasTripleVowels(name), "Name '\(name)' has triple vowels")
        }
    }

    // MARK: - Helpers

    private func hasTripleConsonants(_ string: String) -> Bool {
        let vowels: Set<Character> = ["a", "e", "i", "o", "u", "y"]
        var count = 0
        for char in string.lowercased() {
            if char.isLetter && !vowels.contains(char) {
                count += 1
                if count >= 3 { return true }
            } else {
                count = 0
            }
        }
        return false
    }

    private func hasTripleVowels(_ string: String) -> Bool {
        let vowels: Set<Character> = ["a", "e", "i", "o", "u", "y"]
        var count = 0
        for char in string.lowercased() {
            if vowels.contains(char) {
                count += 1
                if count >= 3 { return true }
            } else {
                count = 0
            }
        }
        return false
    }
}
