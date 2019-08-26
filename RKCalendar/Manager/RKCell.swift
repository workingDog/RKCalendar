//
//  RKCell.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKCell: View {
    
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .background(rkDate.getBackgroundColor())
            .cornerRadius(8)
    }
}

#if DEBUG
struct RKCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RKCell(rkDate: RKDate(date: Date(), calendar: Calendar.current, isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(UIScreen.main.bounds.width/8))
                .previewDisplayName("Control")
            RKCell(rkDate: RKDate(date: Date(), calendar: Calendar.current, isDisabled: true, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(UIScreen.main.bounds.width/8))
                .previewDisplayName("Disabled Date")
            RKCell(rkDate: RKDate(date: Date(), calendar: Calendar.current, isDisabled: false, isToday: true, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(UIScreen.main.bounds.width/8))
                .previewDisplayName("Today")
            RKCell(rkDate: RKDate(date: Date(), calendar: Calendar.current, isDisabled: false, isToday: false, isSelected: true, isBetweenStartAndEnd: false), cellWidth: CGFloat(UIScreen.main.bounds.width/8))
                .previewDisplayName("Selected Date")
            RKCell(rkDate: RKDate(date: Date(), calendar: Calendar.current, isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: true), cellWidth: CGFloat(UIScreen.main.bounds.width/8))
                .previewDisplayName("Between Two Dates")
        }
        .previewLayout(.fixed(width: 300, height: 70))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif

