//
//  CustomColorPicker.swift
//  Hive
//
//  Created by Danil Masnaviev on 22/01/24.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    
    private let colors: [Color] = [.red, .yellow, .orange, .purple, .blue, .indigo, .green, .mint, .black, .white]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .strokeBorder(color == selectedColor ? .appBlack : .appBackground)
                        .frame(width: 40, height: 40)
                        .scaleEffect(color == selectedColor ? 1.2 : 1.0)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding()
            .cornerRadius(20)
        }
    }
}

#Preview {
    CustomColorPicker(selectedColor: .constant(.blue))
}
