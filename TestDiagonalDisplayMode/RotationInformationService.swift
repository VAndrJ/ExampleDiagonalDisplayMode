//
//  RotationInformationService.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import CoreMotion
import VATextureKitRx

final class RotationInformationService {
    @Obs.Relay(value: 0)
    var rotationObs: Observable<Double>

    private let manager = CMMotionManager()

    init() {
        manager.deviceMotionUpdateInterval = EnvironmentConfiguration.deviceMotionUpdateInterval
    }

    func start() {
        manager.startDeviceMotionUpdates(to: .main) { [_rotationObs] motionData, error in
            guard error == nil, let attitude = motionData?.attitude else { return }

            let roll = attitude.roll
            let ar = abs(roll)
            let er = (ar > .pi / 2 ? (.pi - ar) * (roll > 0 ? 1 : -1) : roll) * (.pi / 2 - abs(attitude.pitch))
            _rotationObs.rx.accept(min(.pi / 4, max(-.pi / 4, er)))
        }
    }

    func stop() {
        manager.stopDeviceMotionUpdates()
    }
}
