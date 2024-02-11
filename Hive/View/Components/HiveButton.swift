//
//  HiveButton.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import SwiftUI

struct HiveButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Text(title)
                .fontWeight(.bold)
        }
        .buttonStyle(HiveButtonStyle())
    }
}

struct HiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.white)
            .hSpacing()
            .background(configuration.isPressed ? .honey.opacity(0.8) : .honey, in: .rect(cornerRadius: 12))
    }
}

#Preview {
    HiveButton(title: "Кнопка") {
        //
    }
}
