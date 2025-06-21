//
//  ContentView.swift
//  Academic Burnout Coaching (ABC)
//
//  Created by Abdullah A on 12/26/24.
//

import SwiftUI

struct PulseEffect: ViewModifier {
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    func addPulse() -> some View {
        modifier(PulseEffect())
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showAssessment = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(showAssessment: $showAssessment)
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(0)
            
            CoachingView()
                .tabItem {
                    Label("Coaching", systemImage: "person.2.wave.2")
                }
                .tag(1)
            
            ToolsView()
                .tabItem {
                    Label("Resources", systemImage: "wrench.and.screwdriver.fill")
                }
                .tag(2)
        }
        .sheet(isPresented: $showAssessment) {
            BurnoutAssessmentView()
        }
        .tint(.accentColor)
    }
}

struct DashboardView: View {
    @Binding var showAssessment: Bool
    @State private var burnoutScore: Double = 0
    @AppStorage("completedModules") private var completedModulesData: Data = Data()
    @AppStorage("lastLoginDate") private var lastLoginDate = Date()
    @AppStorage("currentStreak") private var currentStreak = 0
    @AppStorage("burnoutAssessmentScore") private var savedBurnoutScore: Double = 0
    @State private var completedModules: Set<Int> = []
    
    var learningProgress: String {
        let validModules = completedModules.filter { $0 >= 1 && $0 <= 8 }
        let completed = min(validModules.count, 8)
        return "\(completed)/8"
    }
    
    var streakText: String {
        return "\(currentStreak) day\(currentStreak == 1 ? "" : "s")"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Quick Assessment Button
                    Button {
                        showAssessment = true
                    } label: {
                        HStack {
                            Image(systemName: "heart.text.clipboard")
                            Text("Daily Burnout Assessment")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Progress Section
                    VStack(spacing: 12) {
                        Text("Your Progress")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack {
                            StatCard(title: "Streak", value: streakText, icon: "flame.fill")
                            StatCard(title: "Learning Progress", value: learningProgress, icon: "book.fill")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Daily Tips Section
                    VStack(spacing: 12) {
                        Text("Helpful Reminders")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)
                        
                        DailyTipCard()
                            .padding(.horizontal)
                    }
                    
                    // Burnout Assessment Section
                    VStack(spacing: 12) {
                        Text("Your Burnout Assessment Score")
                            .font(.headline)
                        
                        if savedBurnoutScore > 0 {
                            VStack(spacing: 15) {
                                ProgressCard(
                                    title: "Burnout Level",
                                    value: savedBurnoutScore,
                                    icon: "figure.fall",
                                    color: .orange
                                )
                                
                                // Recommendations with orange checkmarks
                                VStack(alignment: .leading, spacing: 9) {
                                    Text("Recommendations")
                                        .font(.subheadline)
                                        .bold()
                                    
                                    ForEach(getRecommendations(), id: \.self) { recommendation in
                                        HStack(alignment: .top, spacing: 9) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.orange)
                                            Text(recommendation)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        } else {
                            VStack(spacing: 6) {
                                Text("No Assessment Taken")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Take the daily assessment to track your burnout level")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .onAppear {
                loadCompletedModules()
                updateStreak()
            }
        }
    }
    
    private func updateStreak() {
        let calendar = Calendar.current
        let today = Date()
        
        // Check if last login was yesterday
        if let daysBetween = calendar.dateComponents([.day], from: calendar.startOfDay(for: lastLoginDate), to: calendar.startOfDay(for: today)).day {
            if daysBetween == 1 {
                // Consecutive day, increment streak
                currentStreak += 1
            } else if daysBetween > 1 {
                // Streak broken
                currentStreak = 1
            } else if daysBetween == 0 {
                // Same day, don't change streak
                return
            }
        }
        
        // Update last login date
        lastLoginDate = today
    }
    
    private func loadCompletedModules() {
        if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: completedModulesData) {
            completedModules = decoded
        }
    }
    
    private func getRecommendations() -> [String] {
        if savedBurnoutScore < 30 {
            return [
                "Keep maintaining your current balance",
                "Continue your healthy study habits",
                "Schedule regular check-ins with yourself"
            ]
        } else if savedBurnoutScore < 70 {
            return [
                "Take more frequent study breaks",
                "Practice stress-reduction techniques",
                "Consider adjusting your workload"
            ]
        } else {
            return [
                "Prioritize self-care immediately",
                "Reach out to academic support services",
                "Consider talking to a counselor"
            ]
        }
    }
}

struct ProgressCard: View {
    let title: String
    let value: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .symbolRenderingMode(.hierarchical)
                Text(title)
                Spacer()
                Text("\(Int(value))%")
                    .bold()
            }
            
            ProgressView(value: value, total: 100)
                .tint(color)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .symbolRenderingMode(.hierarchical)
            Text(value)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct CoachingView: View {
    @AppStorage("completedModules") private var completedModulesData: Data = Data()
    @State private var completedModules: Set<Int> = [0]
    @State private var navigationPath = NavigationPath()
    
    let modules = [
        Module(id: 1, title: "Understanding Academic Burnout", icon: "brain.head.profile", color: .blue),
        Module(id: 2, title: "Stress Management Strategies", icon: "figure.cooldown", color: .red),
        Module(id: 3, title: "Time Management", icon: "clock", color: .green),
        Module(id: 4, title: "Focus & Concentration", icon: "target", color: .purple),
        Module(id: 5, title: "Emotional Well-Being", icon: "heart", color: .pink),
        Module(id: 6, title: "Building Healthy Habits", icon: "figure.walk", color: .orange),
        Module(id: 7, title: "Effective Goal Setting", icon: "flag", color: .yellow),
        Module(id: 8, title: "Support Systems", icon: "person.3", color: .mint)
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(modules) { module in
                        NavigationLink(value: module) {
                            ModuleCard(module: module, isLocked: !isModuleUnlocked(module.id))
                        }
                        .disabled(!isModuleUnlocked(module.id))
                    }
                }
                .padding()
            }
            .navigationDestination(for: Module.self) { module in
                ModuleDetailView(
                    module: module,
                    isCompleted: completedModules.contains(module.id),
                    onComplete: { completeModule(module.id) }
                )
            }
            .navigationTitle("Modules")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Modules")
                        .font(.title2.bold())
                }
            }
            .onAppear {
                loadCompletedModules()
            }
        }
    }
    
    private func loadCompletedModules() {
        if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: completedModulesData) {
            completedModules = decoded
        }
    }
    
    private func saveCompletedModules() {
        if let encoded = try? JSONEncoder().encode(completedModules) {
            completedModulesData = encoded
        }
    }
    
    private func completeModule(_ moduleId: Int) {
        withAnimation {
            completedModules.insert(moduleId)
            saveCompletedModules()
        }
    }
    
    private func isModuleUnlocked(_ moduleId: Int) -> Bool {
        moduleId == 1 || completedModules.contains(moduleId - 1)
    }
}

struct Module: Identifiable, Hashable {
    let id: Int
    let title: String
    let icon: String
    let color: Color
    
    // Add hash function
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Add equality operator
    static func == (lhs: Module, rhs: Module) -> Bool {
        lhs.id == rhs.id
    }
}

struct ModuleCard: View {
    let module: Module
    let isLocked: Bool
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(module.color.opacity(0.2))
                    .frame(height: 150)
                
                VStack(spacing: 12) {
                    Image(systemName: isLocked ? "lock.fill" : module.icon)
                        .font(.system(size: 30))
                        .foregroundColor(isLocked ? .gray : module.color)
                        .scaleEffect(isPressed ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    
                    Text("Module \(module.id)")
                        .font(.subheadline)
                        .bold()
                    
                    Text(module.title)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .opacity(isLocked ? 0.6 : 1.0)
        .onAppear {
            // Trigger animation when card appears
            if !isLocked {
                withAnimation {
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPressed = false
                    }
                }
            }
        }
    }
}

struct ModuleDetailView: View {
    let module: Module
    let isCompleted: Bool
    let onComplete: () -> Void
    @Environment(\.dismiss) var dismiss
    @State private var showingQuiz = false
    @State private var quizCompleted = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
                    Image(systemName: module.icon)
                        .font(.system(size: 40))
                        .foregroundColor(module.color)
                        .addPulse()
                    
                    Text(module.title)
                        .font(.title)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Objective Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Objective")
                        .font(.title2)
                        .bold()
                    
                    Text(moduleObjective(for: module.id))
                        .foregroundColor(.secondary)
                }
                
                // Key Topics Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Key Topics")
                        .font(.title2)
                        .bold()
                    
                    ForEach(moduleTopics(for: module.id), id: \.self) { topic in
                        TopicRow(topic: topic)
                    }
                }
                
                Spacer(minLength: 40)
                
                // Complete Module Button
                if quizCompleted {
                    Button {
                        onComplete()
                        dismiss()
                    } label: {
                        Text("Complete and Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Button {
                        showingQuiz = true
                    } label: {
                        Text("Start Quiz")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(module.color)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingQuiz) {
            ModuleQuizView(
                module: module,
                onQuizComplete: { passed in
                    quizCompleted = passed
                    if !passed {
                        showingQuiz = false
                    }
                }
            )
        }
    }
    
    private func moduleObjective(for id: Int) -> String {
        switch id {
        case 1:
            return "Define academic burnout, its symptoms, and its causes."
        case 2:
            return "Teach effective methods to manage and reduce stress."
        case 3:
            return "Develop skills to balance academic responsibilities efficiently."
        case 4:
            return "Improve focus during study sessions and lectures."
        case 5:
            return "Foster emotional health and a positive mindset."
        case 6:
            return "Establish routines that support physical and mental well-being."
        case 7:
            return "Help students set realistic and achievable academic goals."
        case 8:
            return "Encourage students to seek and maintain support networks."
        default:
            return ""
        }
    }
    
    private func moduleTopics(for id: Int) -> [String] {
        switch id {
        case 1:
            return [
                "What is academic burnout?",
                "Recognizing early warning signs",
                "Differentiating burnout from stress",
                "How burnout impacts your academic and personal life"
            ]
        case 2:
            return [
                "The science of stress and its effects on the brain",
                "Relaxation techniques (e.g., deep breathing, mindfulness)",
                "Building resilience to handle academic challenges"
            ]
        case 3:
            return [
                "Prioritization techniques (e.g., Eisenhower Matrix)",
                "Overcoming procrastination",
                "Creating and sticking to realistic schedules"
            ]
        case 4:
            return [
                "Techniques to minimize distractions",
                "The Pomodoro Technique and other study methods",
                "Building a productive study environment"
            ]
        case 5:
            return [
                "Managing feelings of inadequacy or self-doubt",
                "Practicing self-compassion and gratitude",
                "Techniques to deal with academic setbacks constructively"
            ]
        case 6:
            return [
                "The importance of sleep, nutrition, and exercise",
                "Creating a balanced daily routine",
                "Digital detox: Managing screen time effectively"
            ]
        case 7:
            return [
                "The SMART goals framework",
                "Breaking down long-term goals into actionable steps",
                "Tracking progress and celebrating milestones"
            ]
        case 8:
            return [
                "The importance of peer, family, and mentor support",
                "Communicating academic challenges effectively",
                "How to ask for help and utilize campus resources"
            ]
        default:
            return []
        }
    }
}

struct TopicRow: View {
    let topic: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.accentColor)
            Text(topic)
                .foregroundColor(.secondary)
        }
    }
}

struct ResourceRow: View {
    let resource: String
    let contact: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(resource)
                .font(.headline)
                .foregroundColor(.primary)
            Text(contact)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ToolsView: View {
    let resources: [(resource: String, contact: String)] = [
        ("Emergency Services", "Call 9-1-1"),
        ("Suicide & Crisis Lifeline", "Call 9-8-8"),
        ("Mental Health Association Crisis Line", "765-742-0244 or 1-877-419-1632"),
        ("National Suicide Prevention Hotline", "Call 988"),
        ("Child Abuse Hotline", "1-800-800-5556"),
        ("Crisis Text Line", "Text HOME to 741741")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ForEach(resources, id: \.resource) { resource in
                    ResourceRow(resource: resource.resource, contact: resource.contact)
                }
                
                // Warning Message
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                    Text("If you or someone you know is in crisis, don't wait—seek help immediately. Call 9-1-1 or 9-8-8 for emergency support. You are not alone, and there are people ready to help you.")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 0)
            .navigationTitle("G")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Services")
                        .font(.title2.bold())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
