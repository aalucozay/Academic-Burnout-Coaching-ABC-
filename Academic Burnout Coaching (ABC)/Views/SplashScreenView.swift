import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.85  // Start a bit larger to minimize zoom-in effect
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.accentColor.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Image(systemName: "book.closed.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.accentColor)
                    
                    VStack(spacing: 12) {
                        Text("Academic Burnout Coaching")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("From Surviving to Thriving")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self.size = 1.0  // Reduced final size to prevent overshooting screen
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        self.opacity = 0
                        self.size = 1.1  // Less zoom-out effect before transitioning
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
