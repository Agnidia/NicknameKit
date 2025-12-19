import NicknameKit
import SwiftUI

struct ContentView: View {
    @State private var generatedNames: [String] = []
    @State private var selectedStyle: GeneratorStyle = .fantasy
    @State private var syllableCount: Double = 3
    @State private var nameCount: Int = 10

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                controlsSection
                namesListSection
            }
            .padding()
            .navigationTitle("NicknameKit")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Generate", action: generateNames)
                        .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear(perform: generateNames)
    }

    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Style Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Style")
                    .font(.headline)
                Picker("Style", selection: $selectedStyle) {
                    ForEach(GeneratorStyle.allCases, id: \.self) { style in
                        Text(style.rawValue.capitalized)
                            .tag(style)
                    }
                }
                .pickerStyle(.segmented)
            }

            // Syllable Count Slider
            VStack(alignment: .leading, spacing: 8) {
                Text("Syllables: \(Int(syllableCount))")
                    .font(.headline)
                Slider(value: $syllableCount, in: 1 ... 6, step: 1)
            }

            // Name Count Stepper
            HStack {
                Text("Names to generate:")
                    .font(.headline)
                Spacer()
                Stepper("\(nameCount)", value: $nameCount, in: 1 ... 50)
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }

    private var namesListSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Generated Names")
                .font(.headline)

            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 100, maximum: 150)),
                    ],
                    spacing: 12
                ) {
                    ForEach(generatedNames, id: \.self) { name in
                        Text(name)
                            .font(.body.monospaced())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }

    private func generateNames() {
        generatedNames = NicknameKit.generate(
            count: nameCount,
            syllables: Int(syllableCount),
            style: selectedStyle
        )
    }
}

#Preview {
    ContentView()
}
