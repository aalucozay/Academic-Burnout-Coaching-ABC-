import SwiftUI

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
            Text(text)
                .foregroundColor(.primary)
        }
    }
}

struct AnswerButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isSelected ? Color.accentColor : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(12)
        }
    }
}

struct NavigationButtons: View {
    @Binding var currentQuestionIndex: Int
    @Binding var showingResults: Bool
    let totalQuestions: Int
    
    var body: some View {
        HStack {
            if currentQuestionIndex > 0 {
                Button("Previous") {
                    withAnimation {
                        currentQuestionIndex -= 1
                    }
                }
            }
            
            Spacer()
            
            if currentQuestionIndex < totalQuestions - 1 {
                Button("Next") {
                    withAnimation {
                        currentQuestionIndex += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            } else {
                Button("Complete") {
                    showingResults = true
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

 
