
import SwiftUI

struct SplashView: View {
    @State private var isSplashPresented = true
    
    var body: some View {
        if isSplashPresented {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "EEE3CB"), Color(hex: "EEE3CB")]), startPoint: .topLeading, endPoint: .bottomTrailing)

                    .edgesIgnoringSafeArea(.all)
                
                Image("splash_background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Pomodoro Focus Timer")
                        .font(.title)
                        .fontWeight(.bold)
                        .italic() // Make the text italic
                        .padding(.top, 120)
                        .foregroundColor(Color(hex: "000000"))
                    // You can add an app logo or any other relevant content here
                    
                    Spacer()
                }
            }
                        .onAppear {
                            // Simulate a delay for the splash screen
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    isSplashPresented = false
                                }
                            }
                        }
        }
        else {
            ContentView() // Replace with the main content view of your app
        }
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}







#Preview {
    SplashView()
}
