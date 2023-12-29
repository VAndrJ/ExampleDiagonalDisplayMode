//
//  Keyboard.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 29.12.2023.
//

import VATextureKit

class KeyboardLineNode: VADisplayNode {
    let buttons: [ASDisplayNode]

    init(buttons: [ASDisplayNode]) {
        self.buttons = buttons
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        Row(spacing: 6, main: .spaceBetween) {
            buttons
        }
    }
}

class KeyboardButtonNode: VADisplayNode {
    let childNode: ASDisplayNode

    init(childNode: ASDisplayNode) {
        self.childNode = childNode

        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexBasis = .fraction(percent: 8.5)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.6)
    }
}

class KeyboardNumberButtonNode: VADisplayNode {
    let childNode = VATextNode(text: "123", fontStyle: .footnote)

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(CGSize(same: 44))
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.3)
    }
}

class KeyboardShiftButtonNode: VADisplayNode {
    let childNode = VAImageNode(
        image: UIImage(named: "ic_shift"),
        size: CGSize(same: 24),
        contentMode: .center,
        tintColor: { $0.darkText }
    )

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexBasis = .fraction(percent: 13)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.label
    }
}

class KeyboardEmojiButtonNode: VADisplayNode {
    let childNode = VAImageNode(
        image: UIImage(named: "ic_smiley"),
        size: CGSize(same: 24),
        contentMode: .center,
        tintColor: { $0.label }
    )

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexBasis = .fraction(percent: 13)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.3)
    }
}

class KeyboardBackspaceButtonNode: VADisplayNode {
    let childNode = VAImageNode(
        image: UIImage(named: "ic_backspace"),
        size: CGSize(same: 24),
        contentMode: .center,
        tintColor: { $0.label }
    )

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexBasis = .fraction(percent: 13)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.3)
    }
}

class KeyboardReturnButtonNode: VADisplayNode {
    let childNode = VATextNode(text: "return", fontStyle: .footnote)

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexBasis = .fraction(percent: 25)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.3)
    }
}

class KeyboardSpaceButtonNode: VADisplayNode {
    let childNode = VATextNode(text: "space", fontStyle: .footnote)

    init() {
        super.init(corner: .init(radius: .fixed(4)))

        sized(height: 44)
        style.flexGrow = 1
        style.flexShrink = 0.1
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemGray.withAlphaComponent(0.6)
    }
}

class KeyboardImageButtonNode: VADisplayNode {
    let childNode: VAImageNode

    init(named: String) {
        self.childNode = VAImageNode(
            image: UIImage(named: named),
            size: CGSize(same: 32),
            contentMode: .scaleAspectFit,
            tintColor: { $0.label }
        )

        super.init(corner: .init(radius: .fixed(4)))

        sized(CGSize(same: 44))
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }
}
