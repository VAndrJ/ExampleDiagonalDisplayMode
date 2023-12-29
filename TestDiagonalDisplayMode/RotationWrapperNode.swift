//
//  RotationWrapperNode.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import VATextureKitRx

class KeyboardRotationWrapperNode: VADisplayNode {
    let childNode: ASDisplayNode
    let rotationObs: Observable<Double>

    private let bag = DisposeBag()
    private var angle = 0.0 {
        didSet { setNeedsLayout() }
    }

    init(child: ASDisplayNode, rotationObs: Observable<Double>) {
        self.childNode = child
        self.rotationObs = rotationObs

        super.init()

        anchorPoint = CGPoint(x: 0.5, y: 0)
        childNode.anchorPoint = CGPoint(x: 0.5, y: 0)
    }

    override func didLoad() {
        super.didLoad()

        bind()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .apply {
                let absAngle = abs(angle)
                let width = constrainedSize.max.width
                var desiredWidth = width
                let converted = convert(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), to: nil)
                let rotatedHeight = converted.height
                let beyondBoundariesHeight = frame.origin.y + rotatedHeight - lastNodeFrame.height
                if beyondBoundariesHeight > 0 {
                    let visibleHeight = rotatedHeight - beyondBoundariesHeight
                    desiredWidth = min(width, visibleHeight / sin(absAngle))
                }
                $0.style.width = .points(desiredWidth)
                $0.style.layoutPosition = CGPoint(
                    x: (angle < 0 ? 0 : width - desiredWidth) - width * angle * 0.1,
                    y: 0
                )
            }
            .absolutely()
            .padding(.bottom(childNode.frame.height * pow(sin(angle), 2)))
    }

    private func rotate(angle: Double) {
        transform = CATransform3DMakeRotation(-angle, 0, 0, 1)
        childNode
            .animate(
                .positionY(from: childNode.layer.presentation()?.position.y ?? 0, to: frame.width * abs(angle) * 0.2), // Magic number, just to add a small shift down.
                duration: EnvironmentConfiguration.deviceMotionUpdateInterval,
                removeOnCompletion: false
            )
        self.angle = angle
    }

    private func bind() {
        rotationObs
            .subscribe(onNext: self ?>> { $0.rotate(angle:) })
            .disposed(by: bag)
    }
}

class SizingRotationWrapperNode: VADisplayNode {
    let childNode: ASDisplayNode
    let rotationObs: Observable<Double>

    private let bag = DisposeBag()
    private var angle = 0.0 {
        didSet { setNeedsLayout() }
    }

    init(child: ASDisplayNode, rotationObs: Observable<Double>) {
        self.childNode = child
        self.rotationObs = rotationObs

        super.init()

        childNode.anchorPoint = CGPoint(x: 0.5, y: 0)
    }

    override func didLoad() {
        super.didLoad()

        bind()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .apply {
                let absAngle = abs(angle)
                let additionalPadding = angle > 0 ? $0.frame.height * sin(angle) : 0
                let width = constrainedSize.max.width
                var desiredWidth = width / cos(absAngle)
                if !desiredWidth.isFinite {
                    desiredWidth = width
                }
                let xPositionDelta = (desiredWidth - width) / 2
                $0.style.width = .points(desiredWidth)
                $0.style.layoutPosition = CGPoint(x: -xPositionDelta + additionalPadding, y: 0)
            }
            .absolutely()
            .padding(.bottom(childNode.frame.height * pow(sin(angle), 2)))
    }

    private func rotate(angle: Double) {
        transform = CATransform3DMakeRotation(-angle, 0, 0, 1)
        self.angle = angle
    }

    private func bind() {
        rotationObs
            .subscribe(onNext: self ?>> { $0.rotate(angle:) })
            .disposed(by: bag)
    }
}

class BackgroundRotationWrapperNode: VADisplayNode {
    let childNode: ASDisplayNode
    let rotationObs: Observable<Double>

    private let bag = DisposeBag()

    init(child: ASDisplayNode, rotationObs: Observable<Double>) {
        self.childNode = child
        self.rotationObs = rotationObs

        super.init()

        anchorPoint = CGPoint(x: 0.5, y: 0)
        childNode.anchorPoint = CGPoint(x: 0.5, y: 0)
    }

    override func didLoad() {
        super.didLoad()

        bind()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode
            .centered()
    }

    private func rotate(angle: Double) {
        transform = CATransform3DMakeRotation(-angle, 0, 0, 1)
        childNode
            .animate(
                .scale(from: childNode.layer.presentation()?.transform.m11 ?? 1, to: 2),
                duration: EnvironmentConfiguration.deviceMotionUpdateInterval,
                removeOnCompletion: false
            )
            .animate(
                .positionY(from: childNode.layer.presentation()?.position.y ?? 0, to: childNode.frame.width * abs(angle) * 0.2),
                duration: EnvironmentConfiguration.deviceMotionUpdateInterval,
                removeOnCompletion: false
            )
    }

    private func bind() {
        rotationObs
            .subscribe(onNext: self ?>> { $0.rotate(angle:) })
            .disposed(by: bag)
    }
}
