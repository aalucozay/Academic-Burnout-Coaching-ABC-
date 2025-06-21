import Foundation

class DailyTipManager: ObservableObject {
    @Published var currentTip: Tip
    private var tips: [Tip]
    
    init() {
        self.tips = DailyTipManager.defaultTips
        self.currentTip = DailyTipManager.defaultTips.randomElement() ?? DailyTipManager.defaultTips[0]
    }
    
    func getNewTip() {
        var newTip: Tip
        repeat {
            newTip = tips.randomElement() ?? tips[0]
        } while newTip.id == currentTip.id
        
        currentTip = newTip
    }
    
    struct Tip: Identifiable {
        let id = UUID()
        let text: String
        let category: Category
        
        enum Category: String {
            case timeManagement = "Time Management"
            case selfCare = "Self Care"
            case studyHabits = "Study Habits"
            case mentalHealth = "Mental Health"
            case motivation = "Motivation"
            
            var icon: String {
                switch self {
                case .timeManagement: return "deskclock"
                case .selfCare: return "heart"
                case .studyHabits: return "book.pages.fill"
                case .mentalHealth: return "brain.fill"
                case .motivation: return "star"
                }
            }
        }
    }
    
    static let defaultTips: [Tip] = [
        // Time Management Tips
        Tip(text: "Use the Pomodoro Technique: 25 minutes of focused study followed by a 5-minute break.", category: .timeManagement),
        Tip(text: "Plan your most challenging tasks for when you're most alert and productive.", category: .timeManagement),
        Tip(text: "Break large assignments into smaller, manageable tasks.", category: .timeManagement),
        
        // Self Care Tips
        Tip(text: "Take a 5-minute break every hour to stretch and reset your mind.", category: .selfCare),
        Tip(text: "Stay hydrated! Keep a water bottle at your study space.", category: .selfCare),
        Tip(text: "Practice deep breathing exercises when feeling overwhelmed.", category: .selfCare),
        Tip(text: "Ensure you're getting 7-8 hours of sleep each night.", category: .selfCare),
        
        // Study Habits Tips
        Tip(text: "Find a study space that works for you - quiet, well-lit, and comfortable.", category: .studyHabits),
        Tip(text: "Review your notes within 24 hours of taking them to improve retention.", category: .studyHabits),
        Tip(text: "Try teaching concepts to others to reinforce your understanding.", category: .studyHabits),
        
        // Mental Health Tips
        Tip(text: "It's okay to say no to extra commitments when you're feeling overwhelmed.", category: .mentalHealth),
        Tip(text: "Remember that perfection isn't the goal - progress is.", category: .mentalHealth),
        Tip(text: "Take time to acknowledge your achievements, no matter how small.", category: .mentalHealth),
        
        // Motivation Tips
        Tip(text: "Visualize your goals and remind yourself why they matter to you.", category: .motivation),
        Tip(text: "Celebrate small wins along your academic journey.", category: .motivation),
        Tip(text: "Connect with peers who inspire and motivate you.", category: .motivation)
    ]
} 
