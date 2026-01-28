//
//  ContentView.swift
//  FureverTest
//
//  Created by Gabby on 2026/1/28.
//

import SwiftUI

// MARK: - Data Models

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let petDialogue: String
    let timestamp: Date
    let imageName: String
}

struct PetPhoto: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let timestamp: Date
}

// MARK: - Sample Data

let sampleActivities: [Activity] = [
    Activity(
        title: "The new start",
        description: "The pet's form solidifies from a mist of warm light onto the dirt path. They pause before the mushroom house, sensing a deep, ancient familiarity.",
        petDialogue: "Finally... Stillness.",
        timestamp: Calendar.current.date(bySettingHour: 12, minute: 31, second: 0, of: Date()) ?? Date(),
        imageName: "dog_mushroom"
    ),
    Activity(
        title: "Morning walk",
        description: "Your pet discovered a beautiful butterfly in the garden. They chased it playfully through the flowers.",
        petDialogue: "What a colorful friend!",
        timestamp: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
        imageName: "dog_butterfly"
    ),
    Activity(
        title: "Cozy nap time",
        description: "After a long adventure, your pet found the perfect sunny spot to rest. Dreams of treats dance in their head.",
        petDialogue: "Zzz... treats...",
        timestamp: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
        imageName: "dog_nap"
    )
]

let samplePhotos: [PetPhoto] = [
    PetPhoto(imageName: "dog_mushroom", title: "The new start", timestamp: Date()),
    PetPhoto(imageName: "dog_butterfly", title: "Morning walk", timestamp: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date()),
    PetPhoto(imageName: "dog_nap", title: "Cozy nap time", timestamp: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
    PetPhoto(imageName: "dog_play", title: "Playtime", timestamp: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()),
    PetPhoto(imageName: "dog_eat", title: "Dinner time", timestamp: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()),
    PetPhoto(imageName: "dog_sleep", title: "Sweet dreams", timestamp: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date())
]

// MARK: - Main Content View

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            // Background Image
            Image("background_mushroom")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            // Rain overlay effect
            RainOverlay()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                TopNavigationBar(selectedTab: $selectedTab)
                
                // Date and Weather Row
                DateWeatherRow()
                
                Spacer()
                
                // Main Content based on selected tab
                if selectedTab == 0 {
                    ActivityView(activities: sampleActivities)
                } else {
                    PhotoWallView(photos: samplePhotos)
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - Rain Overlay Effect

struct RainOverlay: View {
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<50, id: \.self) { index in
                RainDrop()
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: CGFloat.random(in: 0...geometry.size.height)
                    )
            }
        }
        .allowsHitTesting(false)
    }
}

struct RainDrop: View {
    @State private var offset: CGFloat = -100
    
    var body: some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(width: 1, height: CGFloat.random(in: 10...20))
            .offset(y: offset)
            .onAppear {
                withAnimation(
                    Animation.linear(duration: Double.random(in: 0.5...1.5))
                        .repeatForever(autoreverses: false)
                ) {
                    offset = 900
                }
            }
    }
}

// MARK: - Top Navigation Bar

struct TopNavigationBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // Tab Switcher (Activity / Photos)
            HStack(spacing: 0) {
                // Activity Tab
                Button(action: { selectedTab = 0 }) {
                    ZStack {
                        if selectedTab == 0 {
                            Circle()
                                .fill(Color(red: 0.85, green: 0.95, blue: 0.75))
                                .frame(width: 44, height: 44)
                        }
                        Image(systemName: "calendar")
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == 0 ? .black : .white)
                    }
                }
                .frame(width: 50, height: 50)
                
                // Photos Tab
                Button(action: { selectedTab = 1 }) {
                    ZStack {
                        if selectedTab == 1 {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.7, green: 0.9, blue: 0.85))
                                .frame(width: 44, height: 44)
                        }
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == 1 ? .black : .white)
                    }
                }
                .frame(width: 50, height: 50)
            }
            .padding(4)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.2))
            )
            
            Spacer()
            
            // Right side icons
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
                
                Button(action: {}) {
                    Image(systemName: "diamond")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
}

// MARK: - Date Weather Row

struct DateWeatherRow: View {
    var body: some View {
        HStack(alignment: .top) {
            // Date Display
            VStack(alignment: .leading, spacing: 2) {
                Text("TODAY")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Text(formattedDate())
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            // Weather Display
            HStack(spacing: 8) {
                Image(systemName: "cloud.rain.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                Text("5°C")
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let day = Calendar.current.component(.day, from: Date())
        let suffix: String
        switch day {
        case 1, 21, 31: suffix = "st"
        case 2, 22: suffix = "nd"
        case 3, 23: suffix = "rd"
        default: suffix = "th"
        }
        return formatter.string(from: Date()) + suffix
    }
}

// MARK: - Activity View

struct ActivityView: View {
    let activities: [Activity]
    @State private var expandedActivityId: UUID?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(activities) { activity in
                    ActivityCard(
                        activity: activity,
                        isExpanded: expandedActivityId == activity.id,
                        onTap: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                if expandedActivityId == activity.id {
                                    expandedActivityId = nil
                                } else {
                                    expandedActivityId = activity.id
                                }
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

// MARK: - Activity Card (Collapsed)

struct ActivityCard: View {
    let activity: Activity
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        if isExpanded {
            ExpandedActivityCard(activity: activity, onTap: onTap)
        } else {
            CollapsedActivityCard(activity: activity, onTap: onTap)
        }
    }
}

struct CollapsedActivityCard: View {
    let activity: Activity
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                // Pet Image
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange.opacity(0.3))
                        .frame(width: 140, height: 160)
                    
                    // Placeholder pet image
                    Image(systemName: "dog.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.orange)
                    
                    // "Powered by Furever" label
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Powered by ")
                                .font(.system(size: 8))
                                .foregroundColor(.gray) +
                            Text("Furever")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(8)
                    }
                }
                .frame(width: 140, height: 160)
                .background(Color.white)
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    
                    // Title
                    Text(activity.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    // Timestamp
                    Text(formatTimestamp(activity.timestamp))
                        .font(.system(size: 11))
                        .foregroundColor(.green)
                    
                    Spacer()
                }
                
                Spacer()
                
                // Detail button
                VStack {
                    Spacer()
                    HStack(spacing: 2) {
                        Text("+ Detail")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - Expanded Activity Card

struct ExpandedActivityCard: View {
    let activity: Activity
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Time badge
            HStack {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text(formatTime(activity.timestamp))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                
                Spacer()
            }
            
            // Title
            Text(activity.title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            
            // Description
            Text(activity.description)
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(4)
            
            // Pet dialogue
            HStack(spacing: 8) {
                Text("🐶")
                    .font(.system(size: 24))
                
                Text(activity.petDialogue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
            }
            
            // View photo button
            Button(action: {
                // Handle view photo action
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "photo")
                        .font(.system(size: 16))
                    Text("View photo")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.85))
                .cornerRadius(25)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.15))
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.ultraThinMaterial)
                )
        )
        .cornerRadius(24)
        .onTapGesture(perform: onTap)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - Photo Wall View

struct PhotoWallView: View {
    let photos: [PetPhoto]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(photos) { photo in
                    PhotoCard(photo: photo)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

// MARK: - Photo Card

struct PhotoCard: View {
    let photo: PetPhoto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Photo placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [Color.orange.opacity(0.6), Color.yellow.opacity(0.4)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Image(systemName: "dog.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                
                // Powered by Furever
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Powered by ")
                            .font(.system(size: 7))
                            .foregroundColor(.white.opacity(0.7)) +
                        Text("Furever")
                            .font(.system(size: 7, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(6)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(12)
            
            // Title
            Text(photo.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(1)
            
            // Timestamp
            Text(formatDate(photo.timestamp))
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.15))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                )
        )
        .cornerRadius(16)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
