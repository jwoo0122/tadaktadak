//
//  KeyboardPreview.swift
//  tadaktadak
//
//  Created by 정진우 on 9/9/24.
//

import SwiftUI

struct KeyCap: View {
    var targetKey: Int
    var currentKey: Int
    
    var isTarget: Bool {
        targetKey == currentKey
    }
    
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(isTarget ? Color("KeyCap") : Color.gray).opacity(isTarget ? 1 : 0.3).frame(width: 60, height: 60)
        }
    }
}

struct KeyboardPreview: View {
    @Binding var targetKeyIndex: Int
    
    var body: some View {
        HStack {
            ForEach (0..<4) { index in
                KeyCap(targetKey: targetKeyIndex, currentKey: index)
            }
            Spacer()
            ForEach (4..<8) { index in
                KeyCap(targetKey: targetKeyIndex, currentKey: index)
            }
        }
        .padding()
        .frame(width: 600)
    }
}

#Preview {
    struct Preview: View {
        @State var number = 5
        var body: some View {
            KeyboardPreview(targetKeyIndex: $number)
        }
    }

    return Preview()
}
