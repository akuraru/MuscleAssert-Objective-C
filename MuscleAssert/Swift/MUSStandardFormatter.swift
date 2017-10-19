//
//  MAStandardFormatter.m
//  Pods
//
//  Created by akuraru on 2017/01/30.
//
//

class MUSStandardFormatter: MUSFormatterProtocol {
    func format(message: String?, differences: [MUSDifference]) -> String? {
        guard !differences.isEmpty else {
            return nil
        }
    
        return differences.reduce((message ?? "") + "\n") { (m, diff) in
            m + "path: .\(diff.path)\n  left: \(diff.left)\n  right: \(diff.right)\n"
        }
    }
}
