//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Taylor on 10/25/21.
//

import SwiftUI

struct DetailView: View {
    // Need to convert let scrum : DailyScrum to a binding to assure rerendering when modified
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented = false
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                // Adding this navigation link allows the user to get to the meeting timer screen
                NavigationLink(destination: MeetingView()){
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                    }
                HStack{
                    Label("Length", systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack{
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
                // Ignoring accessbility because color is not necessary for voiceover
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("Person"))
                        .accessibilityValue(Text(attendee))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit"){
            isPresented = true
            // Empty initializer create an instance with default values for its properties which are updated with this button
            data = scrum.data
        })
        .navigationTitle(scrum.title)
        // If isPresented is set to true then the app presents EditView using the entire screen
        .fullScreenCover(isPresented: $isPresented){
            NavigationView{
                // Need to include a binding to data
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel"){
                        isPresented = false
                    }, trailing: Button("Done"){
                        isPresented = false
                        scrum.update(from: data)
                    })
            }
        }
        // Displays the scrum title on the list
        
        // Adds rounded corners and insets the list from the parent view
    }
}
// If we are deifning a contanst such as scrum we need to initialize it
// in the preview provider

//Edit screen now passes changes back to the detail screen

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            //Need a constant binding
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}
