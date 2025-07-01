import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedYear = Calendar.current.component(.year, from: Date())

    let calendar = Calendar.current

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("Your Calendar")
                .font(.system(size: 34, weight: .bold))
                .padding(.top)

            Divider()

            Text("Toggle through each day, week, and month to learn more about your pregnancy!")
                .font(.system(size: 17, weight: .semibold))

            // Month and Year Picker
            HStack {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(DateFormatter().monthSymbols[month - 1]).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Spacer()

                Picker("Year", selection: $selectedYear) {
                    ForEach(1900...2100, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal)

            // Calendar Grid
            CalendarMonthView(selectedMonth: selectedMonth, selectedYear: selectedYear)

            Divider()
                .padding(.top)

            // Footer Buttons
            HStack(spacing: 10) {
                Button("Today") {
                    let today = Date()
                    selectedMonth = calendar.component(.month, from: today)
                    selectedYear = calendar.component(.year, from: today)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)

                Button("This Month") {
                    // Already showing selected month
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))

                Button("9-month") {
                    // Custom action
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct CalendarMonthView: View {
    var selectedMonth: Int
    var selectedYear: Int

    let calendar = Calendar.current
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var days: [Date] {
        var dateComponents = DateComponents(year: selectedYear, month: selectedMonth)
        dateComponents.day = 1
        let startDate = calendar.date(from: dateComponents)!

        guard let range = calendar.range(of: .day, in: .month, for: startDate) else { return [] }

        return range.compactMap { day -> Date? in
            var comps = dateComponents
            comps.day = day
            return calendar.date(from: comps)
        }
    }

    func startOffset() -> Int {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = 1

        let date = calendar.date(from: components)!
        let weekday = calendar.component(.weekday, from: date)

        return weekday - calendar.firstWeekday
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(DateFormatter().monthSymbols[selectedMonth - 1]) \(selectedYear)")
                .font(.title2)
                .bold()
                .padding(.top, 10)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                    Text(day.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                ForEach(0..<startOffset(), id: \.self) { _ in
                    Text(" ")
                }

                ForEach(days, id: \.self) { date in
                    let isToday = calendar.isDateInToday(date)
                    Text("\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(isToday ? Color.blue : Color.clear)
                        .foregroundColor(isToday ? .white : .black)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}

