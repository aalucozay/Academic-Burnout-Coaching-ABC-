import SwiftUI

struct QuestionView: View {
    @Binding var currentQuestionIndex: Int
    @Binding var answers: [Int]
    @Binding var showingResults: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: Double(currentQuestionIndex + 1), total: Double(AssessmentData.questions.count))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Question \(currentQuestionIndex + 1) of \(AssessmentData.questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(AssessmentData.questions[currentQuestionIndex].text)
                    .font(.title3)
                    .bold()
                
                Text(AssessmentData.questions[currentQuestionIndex].category.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            VStack(spacing: 12) {
                ForEach(0..<5) { value in
                    AnswerButton(
                        label: AssessmentData.answerLabels[value],
                        isSelected: answers[currentQuestionIndex] == value,
                        action: { selectAnswer(value) }
                    )
                }
            }
            .padding()
            
            Spacer()
            
            NavigationButtons(
                currentQuestionIndex: $currentQuestionIndex,
                showingResults: $showingResults,
                totalQuestions: AssessmentData.questions.count
            )
            .padding()
        }
        .navigationTitle("Burnout Assessment")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func selectAnswer(_ value: Int) {
        answers[currentQuestionIndex] = value
    }
} 