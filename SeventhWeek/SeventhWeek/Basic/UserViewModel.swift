//
//  UserViewModel.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import Foundation

class UserViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let loadTapped = Observable(())
        let resetTapped = Observable(())
    }
    
    struct Output {
        let person: Observable<[Person]> = Observable([])
    }
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.loadTapped.bind { _ in
            self.load()
        }
        input.resetTapped.bind { _ in
            self.reset()
        }
    }
    
    private func load() {
        output.person.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func reset() {
        output.person.value.removeAll()
    }
    
}
