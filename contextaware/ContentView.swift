import SwiftUI

struct ContentView: View {
    @ObservedObject var appState: AppState
    @State private var inputText: String = "text"
    var body: some View {
        HStack(spacing: 10) {
            
            TextField("", text: $inputText)
                .foregroundStyle(.white)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(12)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5))
                )
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView(appState: AppState())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, .light)
}
