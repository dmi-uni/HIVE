//
//  Onboarding.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import SwiftUI

struct Onboarding: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Что нового?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading, spacing: 25) {
                PointView(symbol: "clock.fill", title: "Тайм-трекер", subTitle: "Lorem Ipsum")
                
                PointView(symbol: "chart.bar.fill", title: "Полная Статистика", subTitle: "Lorem Ipsum")
                
                PointView(symbol: "checkmark.circle.fill", title: "Уведомления", subTitle: "Lorem Ipsum")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer(minLength: 10)
            
            Button(action: {
                isFirstLaunch = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.honey, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
        .padding()
    }
    
    @ViewBuilder
    func PointView(symbol: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.honey.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.gray)
            }
        }
    }
}
#Preview {
    Onboarding()
}
