//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Joel Groomer on 1/14/24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            
            configuration.label
        } //: HStack
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
        .padding()
        
        Toggle("Placeholder label", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
    }
}
