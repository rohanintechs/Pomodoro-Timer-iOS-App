
import SwiftUI

struct CircularProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.6), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x4FC0D0), Color(hex: 0x2192FF)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
        }
    }
}





#Preview {
    CircularProgressBar(progress: 0.5)
}
