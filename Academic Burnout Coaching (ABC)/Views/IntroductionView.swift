import SwiftUI

struct IntroductionView: View {
    @Binding var hasSeenIntro: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
            
            Text("Academic Burnout Assessment")
                .font(.title2)
                .bold()
            
            VStack(spacing: 15) {
                InfoRow(icon: "clock.fill", text: "Takes only 3 minutes")
                InfoRow(icon: "chart.bar.fill", text: "Get personalized insights")
                InfoRow(icon: "list.bullet.clipboard.fill", text: "Receive actionable tips")
            }
            .padding()
            
            Text("This assessment is designed to help you understand your current burnout level and provide tailored strategies for managing academic stress.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
            
            Button("Start Assessment") {
                withAnimation {
                    hasSeenIntro = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
} 
