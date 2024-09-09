import SwiftUI
import Combine

struct SubTexts: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
            .opacity(0.5)
    }
}

extension Text {
    func subtexts() -> some View {
        modifier(SubTexts())
    }
}

extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}

struct ContentView: View {
    var exerciseKey: [String] = ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅓ", "ㅏ", "ㅣ", ";"]
    var exerciseKeyEng: [String] = ["a", "s", "d", "f", "j", "k", "l", ";"]
    
    @State private var exercisePrevIndex: Int? = nil
    @State private var exerciseIndex = 0
    @State private var exerciseNextIndex = 1
    
    @State private var wrongInput = false
    
    @FocusState private var focused: Bool
    
    var body: some View {
        VStack {
            VStack {
                Text("자판 연습")
                    .font(.title)
                
                Spacer()
                
                HStack {
                    if let prevIndex = exercisePrevIndex {
                        Text(exerciseKey[prevIndex])
                            .subtexts()
                    } else {
                        Text(":)")
                            .subtexts()
                    }
                    
                    Spacer()
                    Text(exerciseKey[exerciseIndex])
                        .font(.system(size: 100))
                        .foregroundColor(wrongInput ? .red : .primary)
                    Spacer()
                    
                    Text(exerciseKey[exerciseNextIndex])
                        .subtexts()
                }
                .frame(width: 300)
            }
            .frame(height: 100)
            
            Spacer()
            KeyboardPreview(targetKeyIndex: $exerciseIndex)
        }
        .frame(height: 400)
        .padding()
        .focusable()
        .focused($focused)
        .focusEffectDisabled()
        .onChange(of: focused, { oldValue, newValue in
            if newValue == false {
               focused = true
            }
            print(oldValue, newValue)
        })
        .onKeyPress(action: { key in
            print(key)
            
            if key.characters == exerciseKey[exerciseIndex] || key.characters == exerciseKeyEng[exerciseIndex] {
                wrongInput = false
                exercisePrevIndex = exerciseIndex
                exerciseIndex = exerciseNextIndex
                exerciseNextIndex = (0...7).random(without: [exerciseNextIndex])
            } else {
                wrongInput = true
            }
            return .handled
        })
        .onAppear {
            focused = true
        }
    }
}

#Preview {
    ContentView()
}
