//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

protocol MUSDeepDiffProtocol {
    func diff(left: Any?, right: Any?, path: String?) -> [MUSDifference]
}

protocol MUSCustomDiffer {
    func match(left: Any, right: Any) -> Bool
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference]
}

extension MUSCustomDiffer {
    func pathByAppendingPath(path: String?, index: Int) -> String {
        if let path = path {
            return "\(path).\(index)"
        } else {
            return "\(index)"
        }
    }
    func pathByAppendingPath(path: String?, string: String) -> String {
        if let path = path {
            return path.appendingFormat(".%@", string)
        } else {
            return string
        }
    }
}

protocol MUSCustomClassDiffer: MUSCustomDiffer {
    associatedtype MatchType
}
extension MUSCustomClassDiffer {
    
    func match(left: Any, right: Any) -> Bool {
        return left is MatchType && right is MatchType
    }
}

/*
@implementation MUSCustomDiffer

- (BOOL)match:(id)left right:(id)right {
    return NO;
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    return @[];
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSString *)pathByAppendingPath:(NSString *)path string:(NSString *)string {
    return path ? [path stringByAppendingFormat:@".%@", string] : string;
}

@end

@implementation MUSCustomClassDiffer

- (BOOL)match:(id)left right:(id)right {
    return [left isKindOfClass:self.matchClass] && [right isKindOfClass:self.matchClass];
}

@end

NS_ASSUME_NONNULL_END
*/
