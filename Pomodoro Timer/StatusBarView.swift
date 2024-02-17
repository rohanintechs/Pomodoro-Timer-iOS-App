
import SwiftUI

struct StatusBarView: View {
    @State private var selectedTab = 0 // Initialize the selected tab
    
    var body: some View {
        ZStack(alignment: .top) {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color(hex: "C0DBEA"), Color(hex: "F9F5F6")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Status Bar
            VStack(spacing: 0) {
                ZStack {
                    Color(hex: 0xF1F6F9)
                        .frame(height: 55)
                    HStack {
                        TabButton(tabIndex: 0, tabTitle: "Pomodoro", selectedTab: $selectedTab, color: Color(hex: 0x2192FF))
                        TabButton(tabIndex: 1, tabTitle: "Short Break", selectedTab: $selectedTab, color: Color(hex: 0x2192FF))
                        TabButton(tabIndex: 2, tabTitle: "Long Break", selectedTab: $selectedTab, color: Color(hex: 0x2192FF))
                    }
                    .padding(.horizontal, 6)
                }
                .padding(.top, 20)
                
                // TabView with swipe navigation

                    TabView(selection: $selectedTab) {
                        PomodoroView()
                            .tag(0)
                        ShortBreakView()
                            .tag(1)
                        LongBreakView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide the page indicator
                    .gesture(DragGesture().onEnded { value in
                        if value.translation.width > 50 {
                            // Swipe right, go to the previous tab
                            withAnimation {
                                selectedTab = max(selectedTab - 1, 0)
                            }
                        } else if value.translation.width < -50 {
                            // Swipe left, go to the next tab
                            withAnimation {
                                selectedTab = min(selectedTab + 1, 2)
                            }
                        }
                    })
                }
            }
        }
    }

struct TabButton: View {
    let tabIndex: Int
    let tabTitle: String
    @Binding var selectedTab: Int
    let color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .foregroundColor(selectedTab == tabIndex ? color.opacity(1) : .clear)
                .cornerRadius(10)
                .padding(5)
            
            Button(action: {
                selectedTab = tabIndex
            }) {
                Text(tabTitle)
                    .foregroundColor(selectedTab == tabIndex ? .white : .black) // Change text color to white when selected
            }
            .padding()
        }
    }
}



#Preview {
    StatusBarView()
}
