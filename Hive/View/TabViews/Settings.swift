//
//  Settings.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import SwiftUI

struct Settings: View {
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Имя: ")
                        Text("Данил")
                    }
                    HStack {
                        Text("email: ")
                        Text("danil@ example.com")
                            .foregroundStyle(.blue)
                    }
                    HStack {
                        Text("Присоединился: ")
                        Text("10 Dec 2023")
                    }
                }
                
                Spacer()
                
                HiveButton(title: "Выйти") {
//                    viewModel.logOut()
                }
                .padding()
            }
            .navigationTitle("Настройки")
        }
    }
}

#Preview {
    Settings()
}
