//
//  AddActivity.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import SwiftUI

struct AddActivity: View {
    @StateObject var viewModel = AddActivityViewModel()
    @State private var notificationToggle: Bool = true
    @Binding var newActivityPresented: Bool
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Детали")) {
                    TextField("Название", text: $viewModel.title)
                }
                
                Section(header: Text("Цель")) {
                    HStack {
                        HStack {
                            TextField("Цель", value: $viewModel.goal, formatter: numberFormatter)
                                .padding(.horizontal, 12)
                                .padding(.leading, 8)
                                .padding(.vertical, 12)
                                .keyboardType(.decimalPad)
                            
                            Text("часов")
                                .foregroundStyle(.gray)
                                .padding(.trailing, 8)
                            
                            Spacer()
                        }
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 150)
                        .padding(.leading, -20)
                        
                        Spacer()
                                                
                        Picker("", selection: $viewModel.goalType) {
                            ForEach(GoalType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .frame(maxWidth: 120)
                    }
                    .padding(.top, -8)
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Toggle("Напоминания", isOn: $notificationToggle)
                        .tint(.honey)
                    ColorPicker("Цвет", selection: $viewModel.color)
                }
                
                Section {
                    HiveButton(title: "Cохранить") {
                        if viewModel.canSave {
                            viewModel.saveActivity()
                            newActivityPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Ошибка!"), message: Text("Пожалуйста, заполните все поля"))
            }
        }
        .navigationTitle("Новая Активность")
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField("Title", text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 12))
        }
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

#Preview {
    NavigationStack{
        AddActivity(newActivityPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
