import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let category: Category
    
    enum Category: String, CaseIterable {
        case stress
        case timeManagement
        case mentalHealth
        
        var description: String {
            switch self {
            case .stress: return "Stress Management"
            case .timeManagement: return "Time Management"
            case .mentalHealth: return "Mental Well-being"
            }
        }
    }
}

struct BurnoutScore {
    let percentage: Double
    let stressScore: Double
    let timeManagementScore: Double
    let mentalHealthScore: Double
    
    init(percentage: Double, stressScore: Double, timeManagementScore: Double, mentalHealthScore: Double) {
        self.percentage = min(max(percentage, 0), 100)
        self.stressScore = min(max(stressScore, 0), 100)
        self.timeManagementScore = min(max(timeManagementScore, 0), 100)
        self.mentalHealthScore = min(max(mentalHealthScore, 0), 100)
    }
    
    var riskLevel: RiskLevel {
        switch percentage {
        case 0..<30: return .low
        case 30..<70: return .moderate
        default: return .high
        }
    }
}

extension BurnoutScore {
    enum RiskLevel: String, CaseIterable {
        case low = "Low Risk"
        case moderate = "Moderate Risk"
        case high = "High Risk"
        
        var description: String { rawValue }
        
        var color: Color {
            switch self {
            case .low: return .green
            case .moderate: return .orange
            case .high: return .red
            }
        }
    }
} 