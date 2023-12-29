//
//  TextFieldNode.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import VATextureKit

class TextFieldNode: VASizedViewWrapperNode<UITextField> {

    convenience init(placeholder: String) {
        self.init(
            childGetter: {
                UITextField().apply {
                    $0.borderStyle = .roundedRect
                    $0.placeholder = placeholder
                    $0.isUserInteractionEnabled = false
                }
            },
            sizing: .viewHeight
        )
    }
}
