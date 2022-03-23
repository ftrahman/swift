//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Taylor on 10/25/21.
//

import SwiftUI

struct ScrumsView: View {
    // Again need to change our constant let scrums: [DailyScrum] to a binding
    @Binding var scrums: [DailyScrum]
    
    var body: some View{
        List{
            //If we didn't add the ID component to DailyScrum we could
            //pull up different card views using ForEach(scrums, id: \.title)
            //This is not sustainable because user-generated titles will collide
            //Current is simplified due to ID
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                        
                }
                .listRowBackground(scrum.color)
            }
        }
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {}){
            Image(systemName: "plus")
        })
    }
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: {$0.id == scrum.id}) else {
            fatalError("Can't find in array!")
        }
        return $scrums[scrumIndex]
    }
}

//Utility method to retrieve a binding from an individual scrum, accepts a DailyScrum and return
// a Binding<DailyScrum>



//Need to wrap views in NavigationView to imply direction
//ForEach uses a NavigationLink

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
    }
}
