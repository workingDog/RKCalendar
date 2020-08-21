//
//  RKTimeView.swift
//  RKCalendar
//
//  Created by Ringo Wathelet on 2019/10/23.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI


public struct RKTimeView: View {
    
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var rkManager: RKManager
    
    @Binding var date: Date
    @Binding var showTime: Bool
    @Binding var hasTime: Bool
    
    var todayRange: ClosedRange<Date> {
        let min = Calendar.current.startOfDay(for: date)
        let max = min.addingTimeInterval(60*60*24)
        return min...max
    }
    
    public var body: some View {
        VStack (alignment: .leading) {
//            HStack {
//                Button(action: self.onDone ) { Text("Done") }
//                Spacer()
//            }.padding(10)
            
            // ClockPickerView(date: self.$date)
            #if targetEnvironment(macCatalyst)
            RKHoursMinutesPicker(date: self.$date)
            #elseif os(iOS)
            Text("Time").padding(10)
            HStack {
                Spacer()
                DatePicker("", selection: Binding<Date>(
                    get: { self.date },
                    set: {
                        self.date = $0
                        self.update()
                    }
                ),
                in: todayRange, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())   //  WheelDatePickerStyle  GraphicalDatePickerStyle
                .frame(width: 300, height: 200)
                Spacer()
            }
            #endif
        }
        .onAppear(perform: loadData)
    }
    
    public func loadData() {
        // the initial value of the date
        switch rkManager.mode {
        case 0:
            if rkManager.selectedDate != nil && rkManager.calendar.isDate(rkManager.selectedDate, inSameDayAs: date) {
                date = rkManager.selectedDate
            }
        case 1, 2:
            if rkManager.startDate != nil && rkManager.calendar.isDate(rkManager.startDate, inSameDayAs: date) {
                date = rkManager.startDate
            }
            if rkManager.endDate != nil && rkManager.calendar.isDate(rkManager.endDate, inSameDayAs: date) {
                date = rkManager.endDate
            }
        case 3:
            if let ndx = rkManager.selectedDatesFindIndex(date: date) {
                date = rkManager.selectedDates[ndx]
            }
        default:
            break
        }
    }
    
    public func onDone() {
        update()
        showTime = false
        // to go back to the previous view passing through doExit
        self.presentationMode.wrappedValue.dismiss()
    }
    
    public func update() {
        switch rkManager.mode {
        case 0:
            rkManager.selectedDate = date
        case 1, 2:
            if self.rkManager.startDate != nil && self.rkManager.calendar.isDate(self.rkManager.startDate, inSameDayAs: date) {
                self.rkManager.startDate = date
            }
            if self.rkManager.endDate != nil && self.rkManager.calendar.isDate(self.rkManager.endDate, inSameDayAs: date) {
                self.rkManager.endDate = date
            }
        case 3:
            if let ndx = rkManager.selectedDates.firstIndex(where: {rkManager.calendar.isDate($0, inSameDayAs: date)}) {
                rkManager.selectedDates[ndx] = date
            }
        default:
            break
        }
        hasTime.toggle()
    }
    
}


struct RKTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RKTimeView(rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), date: .constant(Date()), showTime: .constant(false), hasTime: .constant(false))
    }
}
