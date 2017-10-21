//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

class MUSOptionalDiffer {
    func diff(left: Any?, right: Any?, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        if left == nil && right == nil {
            return []
        }
        if let left = left {
            return [MUSDifference(path: path ?? "Optional", left: "\(left)", right: "value is none")]
        }
        if let right = right {
            return [MUSDifference(path: path ?? "Optional", left: "value is none", right: "\(right)")]
        }
        fatalError()
    }
}
