//
//  AssignmentData.swift
//  Update Homework Organizer
//
//  Created by Owen Jones on 4/30/20.
//  Copyright © 2020 Owen Jones. All rights reserved.
//

import Foundation

struct AssignmentData: Identifiable {
    let name: String
    let id = UUID()
    let subject: String
    let date: String
    let points: Double
}


class Data: ObservableObject{
    @Published var section = [AssignmentData]()
}

