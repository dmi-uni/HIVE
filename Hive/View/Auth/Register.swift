//
//  Register.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import SwiftUI

struct Register: View {
    @StateObject var viewModel = RegisterViewModel()
    @FocusState private var focused: FocusableField?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                VStack {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(Color.red)
                    } else {
                        Text("Введите свои данные")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .hSpacing(.leading)
                    }
                    
                    TextField("Имя", text: $viewModel.name)
                        .focused($focused, equals: .name)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    focused == .name
                                    ? Color.honey
                                    : Color.appBlack
                                )
                        }
                    
                    TextField("Email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .focused($focused, equals: .email)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    focused == .email
                                    ? Color.honey
                                    : Color.appBlack
                                )
                        }
                    
                    
                    SecureField("Пароль", text: $viewModel.password)
                        .textContentType(.password)
                        .focused($focused, equals: .password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    focused == .password
                                    ? Color.honey
                                    : Color.appBlack
                                )
                        }
                    
                    HiveButton(title: "Создать аккаунт") {
                        viewModel.register()
                    }
                    .padding(.top, 10)
                }
            }
            .vSpacing(.top)
            .padding(15)
            .navigationTitle(Text("Регистрация"))
        }
    }
}

#Preview {
    Register()
}
