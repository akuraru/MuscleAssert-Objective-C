//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

extension String.Index: Hashable {
    public var hashValue: Int {
        return self.encodedOffset
    }
}

class MUSStringDiffer: MUSCustomClassDiffer {
    typealias MatchType = String
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        guard let left = left as? String, let right = right as? String else {
            fatalError("none reach")
        }
        let diff = lcsDiff(left: left, right: right)
    
        return diff.map { d in
            MUSDifference(path: pathByAppendingPath(path:path, index:d.index), left:d.left, right:d.right)
        }
    }
    func lcsDiff(left: String, right: String) -> [(index: Int, left: String, right: String)] {
        let lcs = longestCommonSubsequence(left: left, right: right)
        let l1 = left.endIndex
        let l2 = right.endIndex
        let lc = lcs.endIndex
        var idx1 = left.startIndex;
        var idx2 = right.startIndex;
        var idxc = lcs.startIndex;
        var s1 = String()
        var s2 = String()
        var res = [(index: Int, left: String, right: String)]()
        while true {
            if idxc >= lc { break }
            let c1 = left[idx1]
            let c2 = right[idx2]
            let cc = lcs[idxc]
            if ((c1 == cc) && (c2 == cc)) {
                if !s1.isEmpty || !s2.isEmpty {
                    res.append((idxc.encodedOffset, s1, s2))
                    s1 = String()
                    s2 = String()
                }
                idx1 = left.index(after: idx1)
                idx2 = right.index(after: idx2)
                idxc = lcs.index(after: idxc)
                continue;
            }
            if (c1 != cc) {
                s1.append(c1)
                idx1 = left.index(after: idx1)
            }
            if (c2 != cc) {
                s2.append(c2)
                idx2 = right.index(after: idx2)
            }
        }
        if (idx1 < l1) {
            s1.append(String(left[idx1..<left.endIndex]))
        }
        if (idx2 < l2) {
            s2.append(String(right[idx2..<right.endIndex]))
        }
        if !s1.isEmpty || !s2.isEmpty {
            res.append((idxc.encodedOffset, s1, s2))
        }
        return res;
    }
    func longestCommonSubsequence(left : String, right: String) -> String {
        var lengths = [String.Index: [String.Index: Int]]()
        
        lengths[left.startIndex] = [String.Index: Int]()
        for leftIndex in left.indices {
            lengths[left.index(after: leftIndex)] = [String.Index: Int]()
            for rightIndex in right.indices {
                if left[leftIndex] == right[rightIndex] {
                    lengths[left.index(after: leftIndex)]![right.index(after: rightIndex)] = (lengths[leftIndex]?[rightIndex] ?? 0) + 1
                } else {
                    lengths[left.index(after: leftIndex)]![right.index(after: rightIndex)] = max(lengths[left.index(after: leftIndex)]?[rightIndex] ?? 0, lengths[leftIndex]?[right.index(after: rightIndex)] ?? 0)
                }
            }
        }
        
        var lcs = [Character]()
        var x = left.endIndex
        var y = right.endIndex
        
        while (x != left.startIndex && y != right.startIndex) {
            if (lengths[x]![y] ?? 0 == lengths[left.index(before: x)]![y] ?? 0) {
                x = left.index(before: x)
            } else if (lengths[x]![y] ?? 0 == lengths[x]![right.index(before: y)] ?? 0) {
                y = right.index(before: y)
            } else {
                x = left.index(before: x)
                y = right.index(before: y)
                lcs.append(left[x])
            }
        }
        
        return String(lcs.reversed())
    }
}

