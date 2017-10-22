//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//

//

class MUSDifferentTypeDiffer: MUSCustomDiffer {
    func match(left: Any, right: Any) -> Bool {
        return true
    }
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        return [MUSDifference(path: path ?? "0", left: "\(left)", right: "\(right)")]
    }
}
