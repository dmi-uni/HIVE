//
//  SplashScreen.swift
//  Hive
//
//  Created by Danil Masnaviev on 23/01/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.appDark
            
            VStack{
                Image(uiImage: UIImage(imageLiteralResourceName: "AppIcon"))
                    .resizable()
                    .scaledToFit()
                
                Text("HIVE")
                    .font(.title.bold())
                    .foregroundStyle(.white)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
