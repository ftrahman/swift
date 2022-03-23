//
//  EditView.swift
//  Scrumdinger
//
//  Created by Taylor on 10/25/21.
//

import SwiftUI

struct EditView: View {
    // @State for scrumData now becomes binding since we want to act on data from
    // the detail screen instead of creating a snew source of truth
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    var body: some View {
        List {
            Section(header: Text("Meeting Info")){
                // TextField takes a binding to string, which is a reference to a state from another view
                // You can access a binding to scrumData.title with $scrumData.title
                TextField("Title", text: $scrumData.title)
                HStack{
                    Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text("Length")
                    }
                    .accessibilityValue(Text("\(Int(scrumData.lengthInMinutes)) minutes"))
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ColorPicker("Color", selection: $scrumData.color)
                    .accessibilityLabel(Text("Color picker"))
            }
            Section(header: Text("Attendees")){
                ForEach(scrumData.attendees, id:\.self) { attendee in
                    Text(attendee)
                }
                // Calls the closure you pass to onDelete when the user swipes to delete a row
                .onDelete{ indices in
                    scrumData.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text:$newAttendee)
                    Button(action:{
                        withAnimation{
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Add attendee"))
                    }
                    .disabled(newAttendee.isEmpty)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        // Need to create a constant binding 
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}
