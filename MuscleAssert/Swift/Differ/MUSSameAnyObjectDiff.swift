//
//  MUSSameAnyObjectDiff.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/10/29.
//

import Foundation
import ObjectiveC

class MUSSameAnyObjectDiff: MUSCustomDiffer {
    func match(left: Any, right: Any) -> Bool {
        guard let left = left as? NSObject, let right = right as? NSObject else {
            return false;
        }
        return left.isKind(of: right.classForCoder) || right.isKind(of: left.classForCoder)
    }
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        guard let left = left as? NSObject, let right = right as? NSObject else {
            fatalError()
        }
        if left.isEqual(right) {
            return []
        }
        let cls = left.isKind(of: right.classForCoder) ? left : right
        var count: UInt32 = 0
        let props = class_copyPropertyList(cls.classForCoder, &count)
        if count == 0 {
            return [MUSDifference(path: path ?? "0", left: left.debugDescription, right: right.debugDescription)]
        }
        var results: [MUSDifference] = []
        for index in 0..<Int(count) {
            let property = props![index]
            let name = property_getName(property)
            let propertyName = NSString(utf8String: name)! as String
            let selector = NSSelectorFromString(propertyName)
            
            let type = property_getAttributes(property)
            let typeString = NSString(utf8String: type!)! as String
            let attributes = typeString.split(separator: ",")
            let typeAttribute = attributes[0]
            let propertyType = String(typeAttribute[typeAttribute.index(after: typeAttribute.startIndex)])
            
            if propertyType.hasPrefix("@") {
                let leftObject = left.perform(selector)
                let rightObject = right.perform(selector)
                if let leftObject = leftObject, let rightObject = rightObject {
                    results.append(contentsOf: delegatge.diff(left: leftObject.takeUnretainedValue(), right: rightObject.takeUnretainedValue(), path: self.pathByAppendingPath(path: path, string: propertyName)))
                } else {
                    results.append(contentsOf: delegatge.diff(left: leftObject, right: rightObject, path: self.pathByAppendingPath(path: path, string: propertyName)))
                }
            }
        }
        if results.count == 0 {
            return [MUSDifference(path: path ?? "0", left: left.debugDescription, right: right.debugDescription)]
        }
        return results;
    }
}
