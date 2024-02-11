//
//  ActivityCard.swift
//  Hive
//
//  Created by Danil Masnaviev on 22/01/24.
//

import SwiftUI

struct ActivityCard: View {
    let activity: Activity
    let sessions: [Session]
    
    var body: some View {
        let backgroundColor = Color.fromHexString(activity.color)
        let foregroundColor = backgroundColor.isDark ? Color.white : Color.black
        
        let goal = activity.goal
        
        let sessionNum = sessions.count
        let goalProgress = getGoalProgress(sessions, GoalType(rawValue: activity.goalType) ?? GoalType.weekly)
        
        HStack {
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.title.bold())
                
                switch GoalType(rawValue: activity.goalType) {
                case .daily:
                    Text("\(goalProgress.toHours())/\(goal.toHours()) ч. сегодня")
                        .font(.caption)
                case .monthly:
                    Text("\(goalProgress.toHours())/\(goal.toHours()) ч. в этом месяце")
                        .font(.caption)
                
                default:
                    Text("\(goalProgress.toHours())/\(goal.toHours()) ч. на этой неделе")
                        .font(.caption)
                }
                
                
                HStack {
                    Text("Всего: ")
                        .font(.caption.bold())
                    
                    Spacer()
                    
                    VStack {
                        Text(activity.totalTime.toHours())
                            .font(.subheadline.bold())
                        Text("часов")
                            .font(.caption2)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("\(sessionNum)")
                            .font(.subheadline.bold())
                        Text("сессий")
                            .font(.caption2)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    
                }
                .padding(.top)
            }
            .padding()
            
            Spacer()
            
            ProgressCircleView(percentage: getPercentage(goal, goalProgress))
                .padding(.vertical, 20)
                .padding(.horizontal)
            
        }
        .foregroundStyle(foregroundColor)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(backgroundColor)
        .modifier(CardModifier())
        .padding(10)
    }
    
    func getGoalProgress(_ sessions: [Session], _ goalType: GoalType) -> TimeInterval {
        switch goalType {
        case .daily:
            let today = Date()
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: today)
            let endOfDay = calendar.date(byAdding: .second, value: 86399, to: startOfDay)!
            let filteredSessions = sessions.filter {
                formatDate($0.dateStarted) >= startOfDay && formatDate($0.dateStarted) <= endOfDay
            }
            var goalProgress: TimeInterval = 0
            for session in filteredSessions {
                goalProgress += session.duration
            }
            return goalProgress
            
        case .weekly:
            let today = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
            let startOfWeek = calendar.date(from: components)!
            let endOfWeek = calendar.date(byAdding: .second, value: 604799, to: startOfWeek)!
            
            let filteredSessions = sessions.filter {
                calendar.isDate(formatDate($0.dateStarted), inSameDayAs: startOfWeek)
                || (formatDate($0.dateStarted) > startOfWeek && formatDate($0.dateStarted) <= endOfWeek) }
            
            var goalProgress: TimeInterval = 0
            for session in filteredSessions {
                goalProgress += session.duration
            }
            return goalProgress
            
        case .monthly:
            let today = Date()
            let calendar = Calendar.current
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))!
            let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
            
            let filteredSessions = sessions.filter {
                formatDate($0.dateStarted) >= startOfMonth && formatDate($0.dateStarted) <= endOfMonth
            }
            
            var goalProgress: TimeInterval = 0
            for session in filteredSessions {
                goalProgress += session.duration
            }
            return goalProgress
        }
    }
    
    private func getPercentage(_ goal: TimeInterval, _ progress: TimeInterval) -> Double {
        if progress > 0 {
            return progress / goal * 100
        } else {
            return 0
        }
    }
    
    private func formatDate(_ date: String) -> Date {
        let formatted = DateConverter.shared.dateFromString(date) ?? Date()
        
        return formatted
    }
}

struct ProgressCircleView: View {
    var percentage: Double
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.8), style: StrokeStyle(lineWidth: 10))
                    .frame(width: 75, height: 75)
                
                Circle()
                    .trim(from: 0, to: CGFloat(min(percentage / 100, 1.0)))
                    .stroke(Color.honey, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 75, height: 75)
                
                Text(String(format: "%.1f%%", percentage))
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
        }
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 0)
    }
}

#Preview {
    ActivityCard(activity: Activity(id: "", title: "Активность", dateAdded: "2024-01-22", totalTime: 200000, goal: 20000, goalType: "в Неделю", goalCompleted: 5, color: "#f9f7f3"), sessions: [Session(id: "", activityID: "", activityName: "Активность", dateStarted: "2024-01-22", startTime: "19:02", endTime: "21:55" , duration: 10386)])
}
