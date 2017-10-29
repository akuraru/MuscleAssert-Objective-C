//
//  TestModel.swift
//  SwiftTest
//
//  Created by akuraru on 2017/10/21.
//

import Foundation

class TestModel: NSObject {
    let string: String
    let integer: Int
    
    init(string: String = "", integer: Int = 0) {
        self.string = string
        self.integer = integer
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TestModel else {
            return false;
        }
        return self.string == object.string &&
            self.integer == object.integer
    }
    
    override var description: String {
        return "TestModel(string: \(string), integer: \(integer))"
    }
}
