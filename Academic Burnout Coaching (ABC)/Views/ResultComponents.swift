import SwiftUI

struct ScoreHeader: View {
    let score: BurnoutScore
    
    var body: some View {
        VStack(spacing: 16) {
            Text(score.riskLevel.description)
                .font(.title)
                .foregroundColor(score.riskLevel.color)
            
            Text("\(Int(score.percentage))%")
                .font(.system(size: 48, weight: .bold))
            
            Text("Overall Burnout Risk")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct CategoryScores: View {
    let score: BurnoutScore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detailed Analysis")
                .font(.headline)
            
            CategoryScoreRow(title: "Stress Level", score: score.stressScore)
            CategoryScoreRow(title: "Time Management", score: score.timeManagementScore)
            CategoryScoreRow(title: "Mental Well-being", score: score.mentalHealthScore)
        }
    }
}

struct CategoryScoreRow: View {
    let title: String
    let score: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            
            HStack {
                ProgressView(value: score, total: 100)
                Text("\(Int(score))%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct RecommendationsSection: View {
    let score: BurnoutScore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recommendations")
                .font(.headline)
            
            ForEach(getRecommendations(), id: \.self) { recommendation in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                    Text(recommendation)
                }
            }
        }
    }
    
    private func getRecommendations() -> [String] {
        switch score.riskLevel {
        case .low:
            return [
                "Maintain your current balance",
                "Schedule regular breaks",
                "Continue practicing self-care"
            ]
        case .moderate:
            return [
                "Review your time management strategies",
                "Consider reducing your workload",
                "Implement stress-reduction techniques"
            ]
        case .high:
            return [
                "Seek support from academic advisors",
                "Take immediate steps to reduce stress",
                "Consider professional counseling"
            ]
        }
    }
}

struct NextStepsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Steps")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                NextStepRow(icon: "book.fill", text: "Explore our coaching modules")
                NextStepRow(icon: "person.2.fill", text: "Join our support community")
                NextStepRow(icon: "calendar", text: "Schedule a coaching session")
            }
        }
    }
}

struct NextStepRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
            Text(text)
        }
    }
} 