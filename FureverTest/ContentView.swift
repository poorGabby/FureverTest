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
        title: "🏸Badminton Time",
        description: "The pet's form solidifies from a mist of warm light onto the dirt path. They pause before the mushroom house, sensing a deep, ancient familiarity.",
        petDialogue: "Finally... Stillness.",
        timestamp: Calendar.current.date(bySettingHour: 12, minute: 40, second: 0, of: Date()) ?? Date(),
        imageName: "sample_dog"
    ),
    Activity(
        title: "Morning walk",
        description: "Your pet discovered a beautiful butterfly in the garden. They chased it playfully through the flowers.",
        petDialogue: "What a colorful friend!",
        timestamp: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
        imageName: "sample_dog"
    ),
    Activity(
        title: "Cozy nap time",
        description: "After a long adventure, your pet found the perfect sunny spot to rest. Dreams of treats dance in their head.",
        petDialogue: "Zzz... treats...",
        timestamp: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
        imageName: "sample_dog"
    )
]

let samplePhotos: [PetPhoto] = [
    PetPhoto(imageName: "sample_dog", title: "🏸Badminton Time", timestamp: Date()),
    PetPhoto(imageName: "sample_dog", title: "Morning walk", timestamp: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date()),
    PetPhoto(imageName: "sample_dog", title: "Cozy nap time", timestamp: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
    PetPhoto(imageName: "sample_dog", title: "Playtime", timestamp: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date()),
    PetPhoto(imageName: "sample_dog", title: "Dinner time", timestamp: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()),
    PetPhoto(imageName: "sample_dog", title: "Sweet dreams", timestamp: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date())
]

// MARK: - Main Content View

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()
                
                // Rain overlay
                Image("rain_overlay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                
                // Top gradient overlay (subtle darkening at top)
                VStack {
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.1),
                            Color.clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: geometry.size.height * 0.4)
                    .rotationEffect(.degrees(180))
                    
                    Spacer()
                }
                .ignoresSafeArea()
                
                // Bottom gradient overlay
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [
                            Color.clear,
                            Color(red: 0.07, green: 0.07, blue: 0.07).opacity(0.88)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 260)
                }
                .ignoresSafeArea()
                
                // Main Content
                VStack(spacing: 0) {
                    // Top Navigation Bar
                    TopNavigationBar(selectedTab: $selectedTab)
                        .padding(.top, 8)
                    
                    // Content based on selected tab
                    if selectedTab == 0 {
                        ActivityHomeView(activities: sampleActivities)
                    } else {
                        PhotoWallView(photos: samplePhotos)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Top Navigation Bar

struct TopNavigationBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // Tab Switcher
            TabSwitcher(selectedTab: $selectedTab)
            
            Spacer()
            
            // Right side icons
            HStack(spacing: 10) {
                // Settings button
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 40, height: 40)
                        Image(systemName: "gearshape")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                
                // Gems button
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 40, height: 40)
                        Image(systemName: "diamond")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Tab Switcher

struct TabSwitcher: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 4) {
            // Events Tab
            Button(action: { 
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedTab = 0 
                }
            }) {
                ZStack {
                    if selectedTab == 0 {
                        Circle()
                            .fill(Color(red: 0.84, green: 1.0, blue: 0.64)) // #D6FFA3
                            .frame(width: 52, height: 52)
                    }
                    
                    Image(systemName: "calendar")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(selectedTab == 0 ? Color(red: 0.16, green: 0.16, blue: 0.16) : .white)
                }
                .frame(width: 52, height: 52)
            }
            
            // Photos Tab
            Button(action: { 
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedTab = 1 
                }
            }) {
                ZStack {
                    if selectedTab == 1 {
                        Circle()
                            .fill(Color(red: 0.76, green: 0.89, blue: 0.96)) // Light blue
                            .frame(width: 52, height: 52)
                    }
                    
                    // Polaroid icon
                    PolaroidIcon()
                        .frame(width: 28, height: 28)
                }
                .frame(width: 52, height: 52)
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.2))
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                )
        )
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .opacity(0.6)
        )
    }
}

// MARK: - Polaroid Icon

struct PolaroidIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.white)
                .frame(width: 24, height: 28)
                .shadow(color: .black.opacity(0.16), radius: 3, x: 0, y: 1)
            
            VStack(spacing: 2) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 0.76, green: 0.89, blue: 0.96))
                    .frame(width: 18, height: 18)
                
                // Paw print
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 6))
                    .foregroundColor(Color(red: 0.76, green: 0.89, blue: 0.96))
            }
            .offset(y: -1)
        }
        .rotationEffect(.degrees(10))
    }
}

// MARK: - Activity Home View

struct ActivityHomeView: View {
    let activities: [Activity]
    @State private var expandedActivityId: UUID?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                // Date and Polaroid Card Row
                HStack(alignment: .top, spacing: 12) {
                    // Date Display
                    VStack(alignment: .leading, spacing: 0) {
                        Text(dayWithSuffix())
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .tracking(-0.408)
                        
                        Text(yearMonth())
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.88))
                            .tracking(0.17)
                    }
                    .frame(width: 51, alignment: .leading)
                    
                    // Latest Activity Polaroid Card
                    if let latestActivity = activities.first {
                        PolaroidCard(activity: latestActivity)
                            .rotationEffect(.degrees(4))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                Spacer().frame(height: 20)
                
                // Activity List (for expanded view)
                ForEach(activities) { activity in
                    if expandedActivityId == activity.id {
                        ExpandedActivityCard(activity: activity) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                expandedActivityId = nil
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
        }
    }
    
    private func dayWithSuffix() -> String {
        let day = Calendar.current.component(.day, from: Date())
        let suffix: String
        switch day {
        case 1, 21, 31: suffix = "st"
        case 2, 22: suffix = "nd"
        case 3, 23: suffix = "rd"
        default: suffix = "th"
        }
        return "\(day)\(suffix)"
    }
    
    private func yearMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.string(from: Date())
    }
}

// MARK: - Polaroid Card

struct PolaroidCard: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            // Photo
            Image(activity.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Text info
            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title)
                    .font(.system(size: 8, weight: .regular, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.16))
                    .tracking(-0.408)
                
                Text(formatTimestamp(activity.timestamp))
                    .font(.system(size: 6.5, weight: .regular, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
                    .tracking(0.087)
            }
            .padding(.horizontal, 3)
        }
        .padding(.horizontal, 6)
        .padding(.top, 6)
        .padding(.bottom, 10)
        .background(Color(red: 0.98, green: 0.98, blue: 0.96)) // #FAF9F4
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.25), radius: 10.5, x: 0, y: 3)
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d HH:mm"
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
                        .font(.system(size: 14, weight: .medium, design: .rounded))
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
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            // Description
            Text(activity.description)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(4)
            
            // Pet dialogue
            HStack(spacing: 8) {
                Text("🐶")
                    .font(.system(size: 24))
                
                Text(activity.petDialogue)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
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
                        .font(.system(size: 16, weight: .medium, design: .rounded))
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
                .fill(.ultraThinMaterial)
        )
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
        ScrollView(showsIndicators: false) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Photos")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("\(photos.count) memories")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.88))
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(photos) { photo in
                    PhotoCard(photo: photo)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 100)
        }
    }
}

// MARK: - Photo Card

struct PhotoCard: View {
    let photo: PetPhoto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            // Photo
            Image(photo.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Text info
            VStack(alignment: .leading, spacing: 2) {
                Text(photo.title)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.16))
                    .lineLimit(1)
                
                Text(formatDate(photo.timestamp))
                    .font(.system(size: 8, weight: .regular, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.16).opacity(0.4))
            }
            .padding(.horizontal, 3)
        }
        .padding(8)
        .background(Color(red: 0.98, green: 0.98, blue: 0.96))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
