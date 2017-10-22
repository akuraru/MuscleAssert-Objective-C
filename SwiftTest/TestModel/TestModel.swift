//
//  TestModel.swift
//  SwiftTest
//
//  Created by akuraru on 2017/10/21.
//

import Foundation

class TestModel {
    let string: String
    let integer: Int
    
    init(string: String = "", integer: Int = 0) {
        self.string = string
        self.integer = integer
    }
}

extension TestModel: Equatable {
    static func ==(lhs: TestModel, rhs: TestModel) -> Bool {
        return lhs.string == rhs.string &&
            lhs.integer == rhs.integer
    }
}

extension TestModel: CustomStringConvertible {
    var description: String {
        return "TestModel(string: \(string), integer: \(integer))"
    }
}
