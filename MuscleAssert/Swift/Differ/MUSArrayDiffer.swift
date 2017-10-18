//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

class MUSArrayDiffer: MUSCustomClassDiffer {
    typealias MatchType = Array<Any>
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        guard let left = left as? [Any], let right = right as? [Any] else {
            fatalError("none reach")
        }
        let leftCount = left.count
        let rightCount = right.count
        let length = min(rightCount, leftCount)
        
        var result = [MUSDifference]()
        for index in 0..<length {
            result.append(contentsOf: delegatge.diff(left:left[index], right:right[index], path: pathByAppendingPath(path:path, index:index)))
        }
        if length < rightCount {
            let tooLongRight = "\(right[length..<(rightCount - length)])"
            result.append(MUSDifference(path:"\(length)..<\(rightCount)", left:"too sort", right:tooLongRight))
        } else if length < leftCount {
            let tooLongLeft = "\(left[length..<(leftCount - length)])"
            result.append(MUSDifference(path:"\(length)..<\(leftCount)", left:tooLongLeft, right:"too sort"))
        }
        return result;
    }
}
