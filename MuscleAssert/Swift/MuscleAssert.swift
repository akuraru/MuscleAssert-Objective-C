//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

class MuscleAssert: MUSDeepDiffProtocol {
    var formatter: MUSFormatterProtocol
    
    let optionalDiffer = MUSOptionalDiffer()
    var differ: [MUSCustomDiffer]
    var lastDiffer: [MUSCustomDiffer]
    
    init() {
        differ = [
            MUSStringDiffer(),
            MUSDateDiffer(),
            MUSURLDiffer(),
            MUSNumberDiffer(),
            MUSDictionaryDiffer(),
            MUSArrayDiffer()
        ]
        lastDiffer = [
            MUSSameTypeDiffer(),
            MUSDifferentTypeDiffer(),
        ]
        formatter = MUSStandardFormatter()
    }
    
    func deepStricEqual(left: Any?, right: Any?) -> String? {
        return deepStricEqual(left:left, right:right, message:nil)
    }
    func deepStricEqual(left :Any?, right: Any?, message: String?) -> String? {
        let differences = diff(left:left, right:right, path:nil)
        return formatter.format(message:message, differences:differences)
    }

    func diff(left: Any?, right: Any?, path: String?) -> [MUSDifference] {
        guard let l = left, let r = right else {
            return optionalDiffer.diff(left: left, right: right, path: path, delegatge: self)
        }
        
        let allDiffer = differ + lastDiffer
        for diff in allDiffer {
            if diff.match(left:l, right:r) {
                return diff.diff(left:l, right:r, path:path, delegatge:self)
            }
        }
        return []
    }

    func cons(custom: MUSCustomDiffer) {
        differ.insert(custom, at: 0)
    }

    func add(custom: MUSCustomDiffer) {
        differ.append(custom)
    }
}
