/// Post-processing utilities for cleaning generated names.
enum PostProcessor {
    /// Cleans a raw generated name by applying phonetic rules.
    ///
    /// - Parameters:
    ///   - name: The raw concatenated name parts
    ///   - pattern: The syllable pattern used (for context-aware cleaning)
    /// - Returns: A cleaned, properly formatted name
    static func clean(_ name: String, pattern _: SyllablePattern) -> String {
        var result = name.lowercased()

        // Remove triple+ consecutive consonants (keep first two)
        result = removeTripleConsonants(result)

        // Remove triple+ consecutive vowels (keep first two)
        result = removeTripleVowels(result)

        // Handle awkward letter combinations
        result = fixAwkwardCombinations(result)

        // Ensure minimum length
        if result.count < 2 {
            result = "na" + result
        }

        // Capitalize first letter
        return capitalize(result)
    }

    /// Capitalizes the first character of the string.
    private static func capitalize(_ string: String) -> String {
        guard let first = string.first else { return string }
        return first.uppercased() + string.dropFirst()
    }

    private static let vowelSet: Set<Character> = ["a", "e", "i", "o", "u", "y"]

    private static func isVowel(_ char: Character) -> Bool {
        vowelSet.contains(char)
    }

    private static func isConsonant(_ char: Character) -> Bool {
        char.isLetter && !isVowel(char)
    }

    private static func removeTripleConsonants(_ input: String) -> String {
        var result = ""
        var consonantCount = 0

        for char in input {
            if isConsonant(char) {
                consonantCount += 1
                if consonantCount <= 2 {
                    result.append(char)
                }
            } else {
                consonantCount = 0
                result.append(char)
            }
        }

        return result
    }

    private static func removeTripleVowels(_ input: String) -> String {
        var result = ""
        var vowelCount = 0

        for char in input {
            if isVowel(char) {
                vowelCount += 1
                if vowelCount <= 2 {
                    result.append(char)
                }
            } else {
                vowelCount = 0
                result.append(char)
            }
        }

        return result
    }

    /// Awkward letter combinations to fix
    private static let awkwardPatterns: [(pattern: String, replacement: String)] = [
        ("xq", "x"),
        ("qx", "q"),
        ("zx", "z"),
        ("xz", "x"),
        ("''", "'"),
        ("' ", "'"),
        (" '", "'"),
    ]

    private static func fixAwkwardCombinations(_ input: String) -> String {
        var result = input

        for (pattern, replacement) in awkwardPatterns {
            result = replaceOccurrences(in: result, of: pattern, with: replacement)
        }

        // Remove leading/trailing apostrophes
        while result.hasPrefix("'") {
            result.removeFirst()
        }
        while result.hasSuffix("'") && !result.isEmpty {
            result.removeLast()
        }

        return result
    }

    /// Replaces all occurrences of a substring.
    private static func replaceOccurrences(in string: String, of target: String, with replacement: String) -> String {
        guard !target.isEmpty else { return string }

        var result = ""
        var remaining = string[...]

        while !remaining.isEmpty {
            if let range = findSubstring(target, in: remaining) {
                result += remaining[..<range.lowerBound]
                result += replacement
                remaining = remaining[range.upperBound...]
            } else {
                result += remaining
                break
            }
        }

        return result
    }

    /// Finds a substring in a string slice.
    private static func findSubstring(_ target: String, in source: Substring) -> Range<String.Index>? {
        guard !target.isEmpty, source.count >= target.count else { return nil }

        var sourceIndex = source.startIndex
        let targetChars = Array(target)

        outer: while sourceIndex <= source.index(source.endIndex, offsetBy: -target.count) {
            var checkIndex = sourceIndex
            for targetChar in targetChars {
                if source[checkIndex] != targetChar {
                    sourceIndex = source.index(after: sourceIndex)
                    continue outer
                }
                checkIndex = source.index(after: checkIndex)
            }
            // Found match
            return sourceIndex ..< checkIndex
        }

        return nil
    }
}
