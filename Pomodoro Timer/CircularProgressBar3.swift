
import SwiftUI

struct CircularProgressBar3: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(hex: 0xFFCF96), Color(hex: 0xFF9800)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
        }
    }
}





#Preview {
    CircularProgressBar3(progress: 0.5)
}
