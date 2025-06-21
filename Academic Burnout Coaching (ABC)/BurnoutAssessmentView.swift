import SwiftUI

struct BurnoutAssessmentView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("burnoutAssessmentScore") private var savedBurnoutScore: Double = 0
    @State private var currentQuestionIndex = 0
    @State private var answers: [Int]
    @State private var showingResults = false
    @State private var hasSeenIntro = false
    
    init() {
        _answers = State(initialValue: Array(repeating: 0, count: AssessmentData.questions.count))
    }
    
    var body: some View {
        NavigationView {
            if !hasSeenIntro {
                IntroductionView(hasSeenIntro: $hasSeenIntro)
            } else if showingResults {
                ResultsView(score: calculateScore(), dismiss: dismiss)
            } else {
                QuestionView(
                    currentQuestionIndex: $currentQuestionIndex,
                    answers: $answers,
                    showingResults: $showingResults
                )
            }
        }
    }
    
    private func calculateScore() -> BurnoutScore {
        let total = answers.reduce(0, +)
        let maxPossible = AssessmentData.questions.count * 4
        let percentage = Double(total) / Double(maxPossible) * 100
        
        savedBurnoutScore = percentage
        
        return BurnoutScore(
            percentage: percentage,
            stressScore: calculateCategoryScore(.stress),
            timeManagementScore: calculateCategoryScore(.timeManagement),
            mentalHealthScore: calculateCategoryScore(.mentalHealth)
        )
    }
    
    private func calculateCategoryScore(_ category: Question.Category) -> Double {
        let categoryQuestions = AssessmentData.questions.enumerated().filter { $0.element.category == category }
        guard !categoryQuestions.isEmpty else { return 0 }
        
        let categoryAnswers = categoryQuestions.map { answers[$0.offset] }
        let total = categoryAnswers.reduce(0, +)
        let maxPossible = categoryQuestions.count * 4
        return Double(total) / Double(maxPossible) * 100
    }
}

#Preview {
    BurnoutAssessmentView()
} 
