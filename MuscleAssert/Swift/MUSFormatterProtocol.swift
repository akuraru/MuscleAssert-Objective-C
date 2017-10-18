//
//  MAFormatterProtocol.swift
//  Pods
//
//  Created by akuraru on 2017/01/30.
//
//

protocol MUSFormatterProtocol {
    func format(message: String?, differences: [MUSDifference]) -> String?
}
