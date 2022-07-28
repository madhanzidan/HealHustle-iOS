//
//  TaskModel.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 25/07/22.
//

import SwiftUI
import Combine

struct Task: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    var taskItem: String
    var taskDetail: String
    var isCompleted: Bool
}

class TaskStore: ObservableObject {
    @Published var tasks:[Task] = []
}
