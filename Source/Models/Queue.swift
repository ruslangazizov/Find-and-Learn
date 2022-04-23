//
//  Queue.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

struct Queue<T> {
    private var items: [T] = []
    
    mutating func enqueue(element: T) {
        items.append(element)
    }
    
    mutating func dequeue() -> T? {
        if items.isEmpty {
            return nil
        } else {
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
}
