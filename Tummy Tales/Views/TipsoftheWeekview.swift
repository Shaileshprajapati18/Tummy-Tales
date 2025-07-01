import SwiftUI

struct Tip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct TipsoftheWeekView: View {
    @Binding var isPresented: Bool
    @State private var showTips = true
       @State private var showSheet = false

    let tips = [
        Tip(title: "Schedule a dental check-up:", description: "If your gums are bleeding, or if your teeth feel loose due to hormone fluctuations, it’s a good idea to see your dentist."),
        Tip(title: "Rest when you can:", description: "Sure, you’re bursting with energy now, but don’t overdo it. Kicking your feet up or taking a nap helps with things like headaches, back aches and overworked joints and muscles."),
        Tip(title: "Look into childbirth classes:", description: "You have a lot to do to get ready for baby’s birth day, and the second trimester will fly by as you try to get all your to-do’s done.")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top bar
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

            // Week info
            Text(getPregnancyWeekText(week: 15))
                .font(.title3)
                .bold()
                .padding(.horizontal)

            // Tips Card
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {
                    withAnimation {
                        showTips.toggle()
                    }
                }) {
                    HStack {
                        Text("Tips of the Week")
                            .font(.headline)
                        Spacer()
                        Image(systemName: showTips ? "chevron.down" : "chevron.right")
                    }
                    .foregroundColor(.black)
                }

                if showTips {
                    ForEach(tips) { tip in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(tip.title)
                                .bold()
                            Text(tip.description)
                                .font(.subheadline)
                        }
                    }

                    Text("Click to see a list of childbirth classes offered near you:")
                        .font(.subheadline)

                    Button("Childbirth classes") {
                        // Your action here
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
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
        .padding(.top)
        
    }

    func getPregnancyWeekText(week: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"

        let startDate = Calendar.current.date(byAdding: .weekOfYear, value: week - 1, to: Date(timeIntervalSinceNow: -15 * 7 * 24 * 60 * 60))!
        let endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate)!

        return "Week \(week): \(formatter.string(from: startDate)) – \(formatter.string(from: endDate))"
    }
}
