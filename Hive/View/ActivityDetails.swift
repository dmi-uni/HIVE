//
//  ActivityDetails.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import SwiftUI

import FirebaseAuth
import FirebaseFirestore

struct ActivityDetails: View {
    let activity: Activity
    let sessions: [Session]
    
    //    @StateObject var viewModel = ActivityDetailsViewModel()
    @State private var elapsedTime: TimeInterval = 0
    @State private var sessionDuration: TimeInterval = 0
    @State private var sessionStartTime: Date = Date()
    
    
    @State private var isRunning: Bool = false
    @State private var isPaused: Bool = false
    
    var body: some View {
        let sessionNum = sessions.count
        
        NavigationStack {
            VStack {
                VStack {
                    Text("Начато: \(activity.dateAdded)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                HStack(spacing: 50) {
                    VStack {
                        Text("\(sessionNum)")
                            .font(.title)
                        Text("Сессий")
                            .font(.subheadline.bold())
                    }
                    
                    VStack {
                        Text("\(activity.totalTime.toHours())")
                            .font(.title)
                        Text("Часов")
                            .font(.subheadline.bold())
                    }
                    
                    VStack {
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.fromHexString(activity.color))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.appBlack, lineWidth: 1)
                            )
                        
                        Text("Цвет")
                            .font(.subheadline.bold())
                    }
                }
                .padding(.top, 24)
                
                Spacer()
                
                HStack {
                    Text("\(formattedTime(elapsedTime))")
                        .font(.system(size: 40))
                        .padding()
                    
                    Button {
                        addTime(minutes: 10)
                    } label: {
                        Image(systemName: "goforward.10")
                            .foregroundStyle(Color.appBlack)
                            .font(.title)
                    }
                    .padding()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    Button{
                        self.saveSession()
                    } label: {
                        Text("Сохранить")
                            .font(.headline)
                            .frame(width: 120)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.appGreen)
                            .cornerRadius(10)
                    }
                    .opacity(elapsedTime > 0 ? 1 : 0.4)
                    
                    Button{
                        self.toggleStartPause()
                    } label: {
                        HStack {
                            Image(systemName: isRunning ? "pause" : "play.fill")
                            Text(isRunning ? "Стоп" : "Старт")
                                .font(.headline)
                        }
                        .frame(width: 120)
                        .padding()
                        .foregroundColor(.white)
                        .background(isRunning ? Color.appRed : Color.honey)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom)
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if self.isRunning && !self.isPaused {
                    self.elapsedTime += 1
                }
            }
            .navigationTitle(activity.title)
            .onDisappear {
                resetTimer()
            }
        }
    }
    
    private func toggleStartPause() {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        
        sessionStartTime = Date()
    }
    
    private func pauseTimer() {
        isRunning = false
        sessionDuration = elapsedTime
    }
    
    private func addTime(minutes: Int) {
        elapsedTime += TimeInterval(minutes * 60)
    }
    
    private func saveSession() {
        isRunning = false
        sessionDuration = elapsedTime
        
        guard let uID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let dateFormatter = DateConverter.shared
        
        if sessionDuration > 0 {
            let newID = UUID().uuidString
            let newSession = Session(
                id: newID,
                activityID: activity.id,
                activityName: activity.title,
                dateStarted: dateFormatter.stringFromDate(sessionStartTime),
                startTime: dateFormatter.getTimeString(sessionStartTime),
                endTime: dateFormatter.getTimeString(Date()),
                duration: sessionDuration
            )
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(uID)
                .collection("sessions")
                .document(newID)
                .setData(newSession.asDictionary())
            
            db.collection("users")
                .document(uID)
                .collection("activities")
                .document(activity.id)
                .updateData([
                    "totalTime": FieldValue.increment(sessionDuration)
                ])
        }
        
        resetTimer()
    }
    
    private func resetTimer() {
        isRunning = false
        elapsedTime = 0
        sessionDuration = 0
    }
    
    private func formattedTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}

#Preview {
    ActivityDetails(activity: Activity(id: "", title: "Активность", dateAdded: "2024-01-22", totalTime: 181.2, goal: 20, goalType: "в Неделю", goalCompleted: 5, color: "#f9f7f3"), sessions: [Session(id: "", activityID: "", activityName: "Активность", dateStarted: "2024-01-22", startTime: "19:02", endTime: "21:55" , duration: 10386)])
}
