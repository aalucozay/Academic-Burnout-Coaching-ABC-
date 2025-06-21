import SwiftUI

struct ModuleQuizView: View {
    let module: Module
    let onQuizComplete: (Bool) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int?
    @State private var correctAnswers = 0
    @State private var showingResults = false
    
    var quiz: ModuleQuiz? {
        ModuleQuizData.getQuiz(for: module.id)
    }
    
    var currentQuestion: QuizQuestion? {
        guard let quiz = quiz else { return nil }
        return quiz.questions[currentQuestionIndex]
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if showingResults {
                    quizResultsView
                } else {
                    quizQuestionView
                }
            }
            .padding()
            .navigationTitle("Module Quiz")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var quizQuestionView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProgressView(value: Double(currentQuestionIndex + 1), 
                        total: Double(quiz?.questions.count ?? 5))
            
            if let question = currentQuestion {
                Text("Question \(currentQuestionIndex + 1) of \(quiz?.questions.count ?? 5)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(question.text)
                    .font(.title3)
                    .bold()
                
                VStack(spacing: 12) {
                    ForEach(0..<question.options.count, id: \.self) { index in
                        Button {
                            selectedAnswer = index
                        } label: {
                            HStack {
                                Text(question.options[index])
                                    .foregroundColor(selectedAnswer == index ? .white : .primary)
                                Spacer()
                            }
                            .padding()
                            .background(selectedAnswer == index ? module.color : Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    if let selected = selectedAnswer {
                        checkAnswer(selected)
                    }
                } label: {
                    Text(currentQuestionIndex == (quiz?.questions.count ?? 5) - 1 ? "Finish" : "Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedAnswer == nil ? Color.gray : module.color)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedAnswer == nil)
            }
        }
    }
    
    private var quizResultsView: some View {
        VStack(spacing: 24) {
            Image(systemName: hasPassed ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(hasPassed ? .green : .red)
            
            Text(hasPassed ? "Congratulations!" : "Keep Learning!")
                .font(.title)
                .bold()
            
            Text("You got \(correctAnswers) out of \(quiz?.questions.count ?? 5) correct")
                .font(.headline)
            
            if hasPassed {
                Text("Click 'Complete and Continue' on the previous screen to proceed")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("Return to Module") {
                    onQuizComplete(true)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("Try again to unlock the next module")
                    .foregroundColor(.secondary)
                
                Button("Try Again") {
                    onQuizComplete(false)
                    resetQuiz()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    private var hasPassed: Bool {
        let passingScore = Double(quiz?.questions.count ?? 5) * 0.8
        return Double(correctAnswers) >= passingScore
    }
    
    private func checkAnswer(_ selected: Int) {
        if let question = currentQuestion {
            if selected == question.correctAnswer {
                correctAnswers += 1
            }
        }
        
        if currentQuestionIndex == (quiz?.questions.count ?? 5) - 1 {
            showingResults = true
        } else {
            currentQuestionIndex += 1
            selectedAnswer = nil
        }
    }
    
    private func resetQuiz() {
        currentQuestionIndex = 0
        selectedAnswer = nil
        correctAnswers = 0
        showingResults = false
    }
} 