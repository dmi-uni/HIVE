//
//  Activities.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

struct Activities: View {
    @StateObject var viewModel = ActivitiesViewModel()
    @FirestoreQuery var items: [Activity]
    @FirestoreQuery var sessionItems: [Session]
    
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
        self._items = FirestoreQuery(collectionPath: "users/\(userID)/activities")
        self._sessionItems = FirestoreQuery(collectionPath: "users/\(userID)/sessions")
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if items.isEmpty {
                        Text("Пока ничего нет :(")
                    } else {
                        ForEach(items) { item in
                            let filteredSessions = sessionItems.filter {$0.activityID == item.id}
                            
                            NavigationLink(destination: ActivityDetails(activity: item, sessions: filteredSessions)) {
                                ActivityCard(activity: item, sessions: filteredSessions)
                            }
                            
                        }
                    }
                }
                .navigationTitle("Активности")
                .toolbar {
                    Button {
                        viewModel.showingAddActivity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $viewModel.showingAddActivity) {
                    NavigationStack{
                        AddActivity(newActivityPresented: $viewModel.showingAddActivity)
                    }
                }
            }
        }
    }
}

#Preview {
    Activities(userID: "lmmLGYusVpf6M9JJZHu0EHLLohP2")
}
