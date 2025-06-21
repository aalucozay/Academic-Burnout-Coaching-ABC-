import SwiftUI

struct ResultsView: View {
    let score: BurnoutScore
    let dismiss: DismissAction
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ScoreHeader(score: score)
                
                CategoryScores(score: score)
                
                RecommendationsSection(score: score)
                
                NextStepsSection()
                
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
        }
        .navigationTitle("Your Results")
        .navigationBarTitleDisplayMode(.inline)
    }
} 