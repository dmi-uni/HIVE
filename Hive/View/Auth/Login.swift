//
//  Login.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import SwiftUI


struct Login: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focused: FocusableField?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(Color.red)
                }
                
                VStack {
                    TextField("Email", text: $viewModel.email)
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
                    
                    
                    HiveButton(title: "Войти") {
                        viewModel.login()
                    }
                    .padding(.top, 10)
                }
                
                HStack {
                    Text("Нет Аккаунта?")
                        .foregroundStyle(.gray)
                    
                    NavigationLink("Зарегестрироваться") {
                        Register()
                    }
                    .foregroundStyle(.honey)
                }
                .padding(.top, 10)
            }
            .vSpacing(.top)
            .padding(15)
            .navigationTitle(Text("Вход"))
        }
    }
}


#Preview {
    Login()
}
