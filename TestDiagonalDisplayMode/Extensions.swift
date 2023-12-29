//
//  Extensions.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import AsyncDisplayKit
@_exported import Swiftional

extension NSObject: Applyable {}

extension ASDisplayNode {
    var lastNodeFrame: CGRect {
        var node: ASDisplayNode? = supernode
        while node?.supernode != nil {
            node = node?.supernode
        }

        return node?.frame ?? frame
    }
}
