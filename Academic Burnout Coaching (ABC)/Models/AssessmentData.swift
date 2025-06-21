import Foundation

struct AssessmentData {
    static let questions: [Question] = [
        Question(text: "How often do you feel overwhelmed by your academic workload?", category: .stress),
        Question(text: "Do you find it challenging to stick to a consistent sleep schedule?", category: .mentalHealth),
        Question(text: "How often do you delay starting important academic tasks?", category: .timeManagement),
        Question(text: "Do you feel drained or unmotivated after long study sessions?", category: .stress),
        Question(text: "How frequently do you skip meals because of tight academic schedules?", category: .mentalHealth),
        Question(text: "Do you find it difficult to manage your time effectively for assignments?", category: .timeManagement),
        Question(text: "How often do you feel nervous about your academic responsibilities?", category: .stress),
        Question(text: "Do you experience difficulty focusing on your studies for extended periods?", category: .mentalHealth),
        Question(text: "How frequently do you feel behind on your coursework?", category: .timeManagement),
        Question(text: "Do you struggle to stay attentive during lectures or study sessions?", category: .mentalHealth),
        Question(text: "How often do you lose sleep due to worrying about academic deadlines?", category: .mentalHealth),
        Question(text: "Do you feel disconnected from social activities because of study commitments?", category: .stress),
        Question(text: "How frequently do you question your academic potential?", category: .mentalHealth),
        Question(text: "Do you sometimes skip meals or rely on unhealthy snacks due to your workload?", category: .mentalHealth),
        Question(text: "Are you hesitant to reach out for academic help when you need it?", category: .timeManagement),
        Question(text: "How often do you feel like quitting your academic pursuits?", category: .stress),
        Question(text: "Do you feel disappointed with your academic progress even when you try hard?", category: .mentalHealth),
        Question(text: "Is it hard for you to acknowledge your successes in academics?", category: .mentalHealth),
        Question(text: "Do you avoid starting tasks because they feel too overwhelming to tackle?", category: .stress),
        Question(text: "How often do you feel unprepared or forgetful about key academic responsibilities?", category: .timeManagement)

    ]
    
    static let answerLabels = [
        "Never",
        "Rarely",
        "Sometimes",
        "Often",
        "Always"
    ]
} 