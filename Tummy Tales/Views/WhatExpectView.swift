import SwiftUI

// MARK: - Main Week Detail View
struct WeekDetailView: View {
    @State private var expandedSection: String? = nil

    enum SheetType: Identifiable {
        case factsFlash, tipsOfWeek, essentialTesting, setupBaby, mealsDiet

        var id: String {
            switch self {
            case .factsFlash: return "factsFlash"
            case .tipsOfWeek: return "tipsOfWeek"
            case .essentialTesting: return "essentialTesting"
            case .setupBaby: return "setupBaby"
            case .mealsDiet: return "mealsDiet"
            }
        }
    }

    @State private var activeSheet: SheetType? = nil

    let sections = [
        "Facts & Flash",
        "Tips of the Week",
        "Essential Testing",
        "Set Up for the Baby",
        "Meals and Diet"
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("What To Expect!")
                        .font(.title)
                        .bold()
                    Spacer()
                    HStack(spacing: 16) {
                        NavigationLink {
                            ResourcesView()
                        } label: {
                            Image("book")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        NavigationLink {
                            CalendarView()
                        } label: {
                            Image("calender")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()
                Divider()

                // Week Range
                Text(getCurrentWeekRange())
                    .font(.headline)
                    .padding(.vertical)

                // Accordion Sections
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(sections, id: \.self) { section in
                            AccordionItem(
                                title: section,
                                isExpanded: expandedSection == section,
                                onHeaderTap: {
                                    withAnimation {
                                        switch section {
                                        case "Facts & Flash":
                                            activeSheet = .factsFlash
                                        case "Tips of the Week":
                                            activeSheet = .tipsOfWeek
                                        case "Essential Testing":
                                            activeSheet = .essentialTesting
                                        case "Set Up for the Baby":
                                            activeSheet = .setupBaby
                                        case "Meals and Diet":
                                            activeSheet = .mealsDiet
                                        default:
                                            expandedSection = (expandedSection == section) ? nil : section
                                        }
                                    }
                                }
                            ) {
                                NavigationLink(destination: DetailScreen(title: section)) {
                                    Text("Tap to explore \(section)")
                                        .font(.subheadline)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .factsFlash:
                    FactsFlashView(isPresented: Binding(get: { activeSheet == .factsFlash }, set: { _ in activeSheet = nil }))
                case .tipsOfWeek:
                    TipsoftheWeekView(isPresented: Binding(get: { activeSheet == .tipsOfWeek }, set: { _ in activeSheet = nil }))
                case .essentialTesting:
                    EssentialTestingView(isPresented: Binding(get: { activeSheet == .essentialTesting }, set: { _ in activeSheet = nil }))
                case .setupBaby:
                    SetupBabyView(isPresented: Binding(get: { activeSheet == .setupBaby }, set: { _ in activeSheet = nil }))
                case .mealsDiet:
                    MealInfoView(isPresented: Binding(get: { activeSheet == .mealsDiet }, set: { _ in activeSheet = nil }))
                }
            }
        }
    }

    func getCurrentWeekRange() -> String {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: today)!
        let endOfWeek = calendar.date(byAdding: .day, value: 7 - weekday, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"

        let range = "\(formatter.string(from: startOfWeek)) – \(formatter.string(from: endOfWeek))"
        let weekNumber = calendar.component(.weekOfYear, from: today)
        return "Week \(weekNumber): \(range)"
    }
}

// MARK: - Accordion Item Component
struct AccordionItem<Content: View>: View {
    let title: String
    let isExpanded: Bool
    let onHeaderTap: () -> Void
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: onHeaderTap) {
                HStack {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
            }

            if isExpanded {
                content()
                    .transition(.opacity)
                    .padding(.horizontal)
            }
        }
        .animation(.easeInOut, value: isExpanded)
    }
}



struct EssentialTestingView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Essential Testing Content")
            Button("Close") {
                isPresented = false
            }
        }
        .padding()
    }
}

struct SetupBabyView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Set Up for the Baby Content")
            HStack {
                Button(action: {
                    isPresented = false // Dismiss the sheet
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer().frame(width: 250)
                    .padding(.bottom)
            }
        }
        .padding()
    }
}

struct MealsDietView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Meals and Diet Content")
            Button("Close") {
                isPresented = false
            }
        }
        .padding()
    }
}


// MARK: - Placeholder Detail Screen
struct DetailScreen: View {
    let title: String

    var body: some View {
        Text("\(title) Details")
            .navigationTitle(title)
    }
}

// MARK: - App Entry Point
struct ContentView: View {
    var body: some View {
        WeekDetailView()
    }
}

#Preview {
    ContentView()
}
