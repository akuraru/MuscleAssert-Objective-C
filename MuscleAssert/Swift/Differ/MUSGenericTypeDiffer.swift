//
//  MUSGenericTypeDiffer.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/10/23.
//

import Foundation

class MUSGenericTypeDiffer<T: Equatable>: MUSCustomClassDiffer {
    typealias MatchType = T
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        guard let left = left as? MatchType, let right = right as? MatchType else {
            fatalError()
        }
        
        if left == right {
            return []
        }
        return [MUSDifference(path: path ?? "\(MatchType.self)", left: "\(left)", right: "\(right)")]
    }
}
