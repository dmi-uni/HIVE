//
//  History.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

import SwiftUI

struct History: View {
    @FirestoreQuery var items: [Session]
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
        self._items = FirestoreQuery(collectionPath: "users/\(userID)/sessions")
    }
    
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showFilterView = true
                } label: {
                    Text("\(format(date: startDate, format: "dd MMM yyyy")) – \(format(date: endDate, format: "dd MMM yyyy"))")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                List(items.filter {
                    DateConverter.shared.dateFromString($0.dateStarted) ?? startDate >= startDate 
                    && DateConverter.shared.dateFromString($0.dateStarted) ?? endDate <= endDate
                }) { item in
                    HistoryItem(activityName: item.activityName, duration: item.duration.toHours(), startTime: item.startTime, endTime: item.endTime, dateStarted: item.dateStarted)
                        .swipeActions {
                            Button {
                                deleteItem(id: item.id)
                            } label: {
                                Text("delete")
                            }
                            .tint(Color.appRed)
                        }
                }
            }
            .navigationTitle("Журнал")
        }
        .overlay {
            ZStack {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
        }
        .animation(.snappy, value: showFilterView)
    }
    
    func deleteItem(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userID)
            .collection("sessions")
            .document(id)
            .delete()
    }
}

#Preview {
    History(userID: "lmmLGYusVpf6M9JJZHu0EHLLohP2")
}
