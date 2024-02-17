
import SwiftUI
import AVFoundation

struct PomodoroView: View {
    @State private var isTimerRunning = false
    @State private var remainingTime = 0
    @State private var workDuration = 25 // Default work duration
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var player: AVAudioPlayer?
    
    private let startButtonColor = Color(hex: 0x2192FF)
    private let stopButtonColor = Color(hex: 0xFF6969)
    private let PlusButtonColor = Color(hex: 0x4B527E)
    private let MinusButtonColor = Color(hex: 0x4B527E)
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                ZStack {
                    CircularProgressBar(progress: calculateProgress())
                    Text(timeFormatted(remainingTime))
                        .font(.system(size: 60))
                        .foregroundColor(MinusButtonColor)
                        
                }
                .padding(.bottom, 40)
                
                HStack {
                    Button(action: {
                        if workDuration > 5  {
                            workDuration -= 5 // Decrease work duration by 5 minutes (with a minimum of 5 minutes)
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(MinusButtonColor)
                    }
                    Text("Work \(workDuration) min")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        if workDuration < 60 {
                            workDuration += 5 // Increase work duration by 5 minutes (up to 60 minutes)
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(PlusButtonColor)
                    }
                    
                    
                }
                .padding(.bottom, 40)
                
                
                VStack {
                    Button(action: {
                        if !isTimerRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }) {
                        Text(isTimerRunning ? "Pause" : "Start")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 60)
                            .background(startButtonColor)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    .padding()
                    
                    Button(action: {
                        resetTimer()
                    }) {
                        Text("Stop")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 60)
                            .background(startButtonColor)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 250.0)
                .padding(.bottom, 50)
                
                
            }
        }
        .onReceive(timer) { _ in
            if isTimerRunning && remainingTime < workDuration * 60 {
                remainingTime += 1
                if remainingTime == workDuration * 60 {
                    playSound()
                }
            }
        }
        
    }
    
    private func startTimer() {
        isTimerRunning = true
    }
    
    private func stopTimer() {
        isTimerRunning = false
    }
    
    private func resetTimer() {
        isTimerRunning = false
        remainingTime = 0
    }
    
    private func timeFormatted(_ seconds: Int) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func calculateProgress() -> Double {
        if isTimerRunning {
            return Double(remainingTime) / Double(workDuration * 60)
        } else {
            return 0.0
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "sound", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: opacity
        )
    }
}






#Preview {
    PomodoroView()
}


