//
//  BottomNavigationBar.swift
//  Pomodoro Timer
//
//  Created by Rohan De Silva on 10/1/23.
//

import SwiftUI

struct BottomNavigationBar: View {
    
    var body: some View {
        TabView {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                VStack {
                    HomeView()
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(Color.gray.opacity(0.2))
                }
                .font(.title2)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Statistics")
                }
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}


#Preview {
    BottomNavigationBar()
}
