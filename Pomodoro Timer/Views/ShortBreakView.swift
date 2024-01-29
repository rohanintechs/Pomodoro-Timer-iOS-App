
import SwiftUI
import AVFoundation

struct ShortBreakView: View {
    @State private var isTimerRunning = false
    @State private var remainingTime = 0
    @State private var breakDuration = 5 // Default break duration
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
                }
                .padding(.bottom, 40)
                
                HStack {
                    Button(action: {
                        if breakDuration < 15 {
                            breakDuration += 5
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(PlusButtonColor)
                    }
                    
                    Text("Break \(breakDuration) min")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        if breakDuration > 5  {
                            breakDuration -= 5 
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(MinusButtonColor)
                    }
                }
                .padding(.bottom, 40)
                
                
                HStack {
                    Button(action: {
                        if !isTimerRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }) {
                        Image(systemName: isTimerRunning ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(startButtonColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        resetTimer()
                    }) {
                        Image(systemName: "stop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(stopButtonColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 250.0)
                .padding(.bottom, 100)
                
                
            }
        }
        .onReceive(timer) { _ in
            if isTimerRunning && remainingTime < breakDuration * 60 {
                remainingTime += 1
                if remainingTime == breakDuration * 60 {
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
            return Double(remainingTime) / Double(breakDuration * 60)
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







#Preview {
    ShortBreakView()
}


