//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

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
        return ""
    }
}
    /*
    const NSUInteger leftLength = left.length;
    const NSUInteger rightLength = right.length;
    
    unsigned int **lengths = malloc((leftLength + 1) * sizeof(unsigned int *));
    
    for (unsigned int i = 0; i <= leftLength; ++i) {
        lengths[i] = malloc((rightLength + 1) * sizeof(unsigned int));
        
        for (unsigned int j = 0; j <= rightLength; ++j) {
            lengths[i][j] = 0;
        }
    }
    
    
    for (unsigned int i = 0; i < leftLength; ++i) {
        for (unsigned int j = 0; j < rightLength; ++j) {
            if ([left characterAtIndex:i] == [right characterAtIndex:j]) {
                lengths[i + 1][j + 1] = lengths[i][j] + 1;
            } else {
                lengths[i + 1][j + 1] = MAX(lengths[i + 1][j], lengths[i][j + 1]);
            }
        }
    }
    
    NSMutableString *lcs = [NSMutableString string];
    NSUInteger x = leftLength;
    NSUInteger y = rightLength;
    
    while (x != 0 && y != 0) {
        if (lengths[x][y] == lengths[x - 1][y]) {
            --x;
        } else if (lengths[x][y] == lengths[x][y - 1]) {
            --y;
        } else {
            [lcs insertString:[NSString stringWithFormat:@"%C", [left characterAtIndex:x - 1]] atIndex:0];
            --x;
            --y;
        }
    }
    
    for (unsigned int i = 0; i <= leftLength; ++i) {
        free(lengths[i]);
    }
    
    free(lengths);
    
    return lcs;
}
}
 */
