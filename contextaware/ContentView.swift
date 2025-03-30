import SwiftUI

// Custom ViewModifiers for reusable styles
struct GlassBackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
            )
    }
}

struct FancyButtonStyle: ButtonStyle {
    let isPrimary: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Group {
                    if isPrimary {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    } else {
                        Color.secondary.opacity(0.1)
                    }
                }
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ContentView: View {
    @ObservedObject var appState: AppState
    @State private var inputText: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.2, green: 0.1, blue: 0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Context Aware")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top)
                
                Picker("Mode", selection: $appState.mode) {
                    Text("Selected Text").tag(AppState.TextExtractionMode.selectedText)
                    Text("All Text").tag(AppState.TextExtractionMode.allText)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                
                // Input Area
                VStack(alignment: .leading, spacing: 8) {
                    Text("Input")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 14, weight: .medium))
                    
                    TextField("Enter or paste text here...", text: $inputText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(12)
                        .font(.system(size: 14))
                        .modifier(GlassBackgroundStyle())
                }
                .padding(.horizontal, 20)
                
                // Summary Area
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Summary")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 14, weight: .medium))
                        Spacer()
                        if appState.isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                                .tint(.white)
                        }
                    }
                    
                    ScrollView {
                        Text(appState.summary)
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .modifier(GlassBackgroundStyle())
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxHeight: .infinity)
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        inputText = ""
                        appState.summary = "Waiting for summary..."
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FancyButtonStyle(isPrimary: false))
                    
                    Button(action: {
                        appState.isLoading = true
                    }) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Process")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FancyButtonStyle(isPrimary: true))
                }
                .padding(.horizontal, 20)
                .padding(.bottom)
            }
            .frame(minWidth: 400, minHeight: 300)
        }
    }
}

#Preview {
    ContentView(appState: AppState())
        .frame(width: 400, height: 500)
        .preferredColorScheme(.dark)
}
