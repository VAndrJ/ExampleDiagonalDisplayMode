//
//  ControllerNode.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import VATextureKitRx

class ControllerNode: VASafeAreaDisplayNode {
    let topSpacerNode = VASpacerNode(flexShrink: 0.2, flexGrow: 2)
    lazy var loginRotationWrapperNode = SizingRotationWrapperNode(
        child: VATextNode(text: "Login", fontStyle: .title1),
        rotationObs: rotationObs
    )
    lazy var userNameRotationWrapperNode = SizingRotationWrapperNode(
        child: TextFieldNode(placeholder: "Username"),
        rotationObs: rotationObs
    )
    lazy var passwordRotationWrapperNode = SizingRotationWrapperNode(
        child: TextFieldNode(placeholder: "Password"),
        rotationObs: rotationObs
    )
    let centerSpacerNode = VASpacerNode(flexShrink: 0.1, flexGrow: 1)
    lazy var keyboardLineRotationWrapperNode = KeyboardRotationWrapperNode(
        child: KeyboardLineNode(buttons: [
            "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"
        ].map { KeyboardButtonNode(childNode: VATextNode(text: $0)) }),
        rotationObs: rotationObs
    )
    lazy var keyboardLine1RotationWrapperNode = KeyboardRotationWrapperNode(
        child: KeyboardLineNode(
            buttons: CollectionOfOne(VASpacerNode()) + [
                "A", "S", "D", "F", "G", "H", "J", "K", "L"
            ].map { KeyboardButtonNode(childNode: VATextNode(text: $0)) } +
            CollectionOfOne(VASpacerNode())
        ),
        rotationObs: rotationObs
    )
    lazy var keyboardLine2RotationWrapperNode = KeyboardRotationWrapperNode(
        child: KeyboardLineNode(
            buttons: [KeyboardShiftButtonNode(), VASpacerNode()] +
            ["Z", "X", "C", "V", "B", "N", "M"].map { KeyboardButtonNode(childNode: VATextNode(text: $0)) } +
            [VASpacerNode(), KeyboardBackspaceButtonNode()]
        ),
        rotationObs: rotationObs
    )
    lazy var keyboardLine3RotationWrapperNode = KeyboardRotationWrapperNode(
        child: KeyboardLineNode(buttons: [
            KeyboardNumberButtonNode(),
            KeyboardEmojiButtonNode(),
            KeyboardSpaceButtonNode(),
            KeyboardReturnButtonNode(),
        ]),
        rotationObs: rotationObs
    )
    lazy var keyboardLine4RotationWrapperNode = KeyboardRotationWrapperNode(
        child: KeyboardLineNode(buttons: [
            KeyboardImageButtonNode(named: "ic_globe"),
            VASpacerNode(),
            KeyboardImageButtonNode(named: "ic_mic"),
        ]),
        rotationObs: rotationObs
    )
    lazy var backgroundRotationWrapperNode = BackgroundRotationWrapperNode(
        child: ASDisplayNode(),
        rotationObs: rotationObs
    )

    private let rotationObs: Observable<Double>

    init(rotationObs: Observable<Double>) {
        self.rotationObs = rotationObs

        super.init()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        Column(cross: .stretch) {
            topSpacerNode
            Column(spacing: 16) {
                loginRotationWrapperNode
                userNameRotationWrapperNode
                passwordRotationWrapperNode
            }
            .padding(.horizontal(16))
            centerSpacerNode
            Column(spacing: 8) {
                keyboardLineRotationWrapperNode
                keyboardLine1RotationWrapperNode
                keyboardLine2RotationWrapperNode
                keyboardLine3RotationWrapperNode
                keyboardLine4RotationWrapperNode
            }
            .padding(.top(8), .horizontal(6))
            .safe(edges: .bottom, in: self)
            .background(backgroundRotationWrapperNode)
        }
    }

    override func configureTheme(_ theme: VATheme) {
        backgroundColor = theme.systemBackground
        backgroundRotationWrapperNode.childNode.backgroundColor = theme.systemGray.withAlphaComponent(0.3)
    }
}
