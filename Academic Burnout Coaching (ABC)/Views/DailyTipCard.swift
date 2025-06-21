import SwiftUI

struct DailyTipCard: View {
    @StateObject private var tipManager = DailyTipManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Daily Tip", systemImage: tipManager.currentTip.category.icon)
                    .font(.headline)
                
                Spacer() 
                
                Button(action: {
                    withAnimation {
                        tipManager.getNewTip()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.accentColor)
                }
            }
            
            Text(tipManager.currentTip.text)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(tipManager.currentTip.category.rawValue)
                .font(.caption)
                .padding(6)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(6)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .transition(.opacity)
    }
}

#Preview {
    DailyTipCard()
        .padding()
} 
