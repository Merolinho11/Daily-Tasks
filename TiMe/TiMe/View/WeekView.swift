

import SwiftUI

// MARK: PICKER WITH DAYS OF THE WEEK

struct WeekView: View {
    
    @EnvironmentObject var day: ChosenDay
    
    var body: some View {
        Picker ("", selection: $day.chosenDay) {
                ForEach(days, id: \.self) { day in
                    Text("\(day)").tag(0)
                }
            }.pickerStyle(.segmented)
            .padding()
    }
}

struct WeekView_Previews: PreviewProvider {
    
    static let day = ChosenDay()

    static var previews: some View {
        WeekView().environmentObject(day)
    }
}
