
import SwiftUI

struct CircularProgressBar2: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(hex: 0xA2FF86), Color(hex: 0x54B435)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
        }
    }
}





#Preview {
    CircularProgressBar2(progress: 0.5)
}
