//
//  ContentView.swift
//  Update Homework Organizer
//
//  Created by Owen Jones on 4/30/20.
//  Copyright © 2020 Owen Jones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack{
            TabView(selection: $selection){
                CheckListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar.circle")
                            Text("Homework Organizer")
                        }
                }
                .tag(0)
                NewAssignmentView()
                    .tabItem {
                        VStack {
                            Image(systemName: "folder.fill.badge.plus")
                            Text("New Assignment")
                        }
                }
                .tag(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CheckListView: View {
    
    
    @ObservedObject var dataCollected = Data()
    
    
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(dataCollected.section) { section in
                    Text(section.name)
                    Section{
                        ForEach(self.dataCollected.section) { section in
                            Text(section.subject)
                            Text(section.date)
                            Text(String(section.points))
                        }
                    }
                }
            }
        .navigationBarTitle("Assignments")
        }
    }
    
    
}

struct NewAssignmentView: View {
    @State private var subject = ""
    @State private var name = ""
    @State private var dueDate = Date()
    @State private var assignmentWorth: Double = 0
    @State var checkListView = CheckListView()
    
    

    
    var body: some View{
        Form{
            
            HStack(alignment: .center){
                Text("Name:")
                TextField("NA", text: self.$name)
            }
            HStack(alignment: .center){
                Text("Subject:")
                TextField("NA", text: self.$subject)
            }
            
            
            DatePicker(selection: $dueDate, label: { Text("Due Date:") })
            // Allows pick due date
            
            
            // pick assignment type
            
            VStack {
                Slider(value: $assignmentWorth, in: 0...250, step: 1)
                Text("\(assignmentWorth) points")
            }
            
            Button(action: {
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                let assignment = AssignmentData(name: self.name, subject: self.subject, date: formatter1.string(from: self.dueDate), points: self.assignmentWorth)
                self.checkListView.dataCollected.section.append(assignment)
                print(assignment)
                self.name = ""
                self.subject = ""
                
                
                
            } ) {
                Text("Complete")
            }
        }
    }
}

