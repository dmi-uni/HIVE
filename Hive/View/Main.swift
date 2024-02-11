//
//  ContentView.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import SwiftUI

struct Main: View {
    @StateObject var viewModel = MainViewModel()
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State private var activeTab: Tab = .activities
    
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                withAnimation {
                    SplashScreen()
                        .transition(.opacity)
                }
            } else {
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                    TabView(selection: $activeTab) {
                        Activities(userID: viewModel.currentUserId)
                            .tag(Tab.activities)
                            .tabItem { Tab.activities.tabContent }
                        
                        History(userID: viewModel.currentUserId)
                            .tag(Tab.history)
                            .tabItem { Tab.history.tabContent }
                        
                        Statistics(userID: viewModel.currentUserId)
                            .tag(Tab.charts)
                            .tabItem { Tab.charts.tabContent }
                        
                        Settings()
                            .tag(Tab.settings)
                            .tabItem { Tab.settings.tabContent }
                    }
                    .background(.appBackground)
                    .sheet(isPresented: $isFirstLaunch, content: {
                        Onboarding()
                            .interactiveDismissDisabled()
                    })
                } else {
                    Login()
                }
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
}

#Preview {
    Main()
}
